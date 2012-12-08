var map;
var geocoder;
var marker;
var lines = new Array();
var start_cur=1
var streets_list={}
var cnt_i=0;
var cnt_work=10;
var timerid;
function sleep(ms)
{
    var dt = new Date();
    dt.setTime(dt.getTime() + ms);
    while (new Date().getTime() < dt.getTime());
}
function initialize() {
    var myOptions = {
        zoom: 16,
        center: new google.maps.LatLng(49.92255,36.4009928000),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        overviewMapControl: true
    };
    map = new google.maps.Map(document.getElementById('map'),myOptions);
    geocoder = new google.maps.Geocoder();

    //reverseGeocode(event.latLng.lat(),event.latLng.lng());
    //});
}
google.maps.event.addDomListener(window, 'load', initialize);

function save_streets(){
    console.info("SAVE STREETS...start_cur="+start_cur)
    $.post(
        "get_geo_streets/save_streets",
        {items:streets_list},
        function (data) {
            console.log("saved data cnt="+data);
            streets_list={};
            start_cur=start_cur+cnt_work;
            cnt_i=0;
        },
        "json"
    )
}
function getStreets(start,end) {
    if (start >= 500){//--ALL RECORDS SEEN 2570
        window.clearInterval(timerid);
        return;
    }
    if (start_cur >100){console.clear();}
    $("#start_txt").val(start_cur)
    console.log("getStreets loading...start_cur="+start_cur);
    $.post(
        "get_geo_streets/get_streets",
        {start:start_cur},
        function (data){
            console.log(data)
            streets_list=data
            streets_work_html=""
            for (var i=0;i < streets_list.length;i++){
                streets_work_html+="<ul>"+streets_list[i].name_rus+"</ul>"
                streets_list[i].lat=0;
                streets_list[i].lng=0;
            }
            $("#streets_in_work").html(streets_work_html)
            fillGeoStreets();
        }
    )
}
function set_latlng(a,b){
   try {
    streets_list[cnt_i].lat=a;
    streets_list[cnt_i].lng=b;
    cnt_i=cnt_i+1;
   }finally {
    //console.log("set lat "+a+" set lng "+b+" cnt_i="+cnt_i);
   }
}
function fillGeoStreets() {
    timerid= window.setInterval(getGEOStreets,1001);
}
function getGEOStreets() {
    if (cnt_i >= cnt_work){
        window.clearInterval(timerid);
        save_streets();
        getStreets(start_cur,cnt_work);
    } else {
        console.log("start getGEOStreets:"+cnt_i);
        if (cnt_i >= streets_list.length ) {
            console.log("ERROR getGEOStreets L="+streets_list.length);
            window.clearInterval(timerid);
            save_streets();
            sleep(2000);
            getStreets();
            return;
        }

        if (streets_list[cnt_i].name_rus == undefined){
            console.log("ERROR getGEOStreets L="+streets_list.length+" cnt_i="+cnt_i);
            window.clearInterval(timerid);
            sleep(2000);
            getStreets();
            return;
        }
        var address = "Харьков,"+ streets_list[cnt_i].name_rus;
        geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                set_latlng(results[0].geometry.location.lat(),results[0].geometry.location.lng())
            } else {
                console.error("Geocode was not successful for cnt_i="+cnt_i+" the following reason: " + status);
            }
        },false);
    }
}
//-------------------GEO--------------------------------
function displayLine(id) {
    var request = new XMLHttpRequest();

    request.open("GET", 'http://api.geonames.org/servlet/geonames?srv=551&username=demo&id=' + id, true);
    request.onreadystatechange = function() {
        if (request.readyState == 4) {
            var xmlDoc = request.responseXML;
            var pointXml = xmlDoc.documentElement.getElementsByTagName("point");
            gLatLngArray = new Array();
            for (var i = 0; i < pointXml.length; i++) {
                var lat = parseFloat(pointXml[i].getElementsByTagName("lat")[0].childNodes[0].nodeValue);
                var lng = parseFloat(pointXml[i].getElementsByTagName("lng")[0].childNodes[0].nodeValue);
                // gLatLngArray.push(new google.maps.LatLng(lat,lng));
                gLatLngArray.push([lat,lng]);
            }
            console.log("Сумская gLatLngArray="+gLatLngArray)
//            var polyline = new google.maps.Polyline({
//                path: gLatLngArray,
//                strokeColor: "#FF0000",
//                strokeOpacity: 1.0,
//                strokeWeight: 2
//            });
//            polyline.setMap(map);
//            lines.push(polyline);
        }
    } // function
    request.send(null);
}

// showLocation() is called when you click on the Search button
// in the form.  It geocodes the address entered into the form
// and adds a marker to the map at that location.
function showLocation(item) {

    var address = "Харьков,"+item.name_rus;//document.getElementById("address").value;
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });
            reverseGeocode(results[0].geometry.location.lat(),results[0].geometry.location.lng());
        } else {
           console.error("Geocode was not successful for the following reason: " + status);
        }
    });
}

function reverseGeocode(lat,lng) {
    document.getElementById("addressDiv").innerHTML = 'loading ...';
   // document.getElementById("intersection").innerHTML = '';
    document.getElementById("address").innerHTML = '';

    var request = new XMLHttpRequest();
    console.log("reverseGeocode...")
    request.setRequestHeader('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
    request.setRequestHeader('Host', 'api.geonames.org')
    request.setRequestHeader('Accept-Encoding', 'gzip, deflate')
    request.setRequestHeader('Origin', 'http://www.geonames.org')
    request.setRequestHeader('Referer', 'http://www.geonames.org/maps/osm-reverse-geocoder.html')
    request.open("GET", 'http://api.geonames.org/servlet/geonames?srv=550&lat=' + lat + '&lng=' + lng + '&username=demo', true);
    request.onreadystatechange = function() {
        if (request.readyState == 4) {
            var xmlDoc = request.responseXML;
            var lines = xmlDoc.documentElement.getElementsByTagName("line");
            console.log("reverseGeocode...done...")
            console.info(lines)

            displayStreetSegments(lines);
        } else {
            console.log("reverseGeocode...error..."+request)
        }
    } // function
    request.send(null);

    var request2 = new XMLHttpRequest();
    request2.setRequestHeader('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
    request2.setRequestHeader('Host', 'api.geonames.org')
    request2.setRequestHeader('Accept-Encoding', 'gzip, deflate')
    request2.setRequestHeader('Origin', 'http://www.geonames.org')
    request2.setRequestHeader('Referer', 'http://www.geonames.org/maps/osm-reverse-geocoder.html')
    request2.open("GET", 'http://api.geonames.org/servlet/geonames?srv=552&lat=' + lat + '&lng=' + lng + '&username=demo', true);
    request2.onreadystatechange = function() {
        if (request2.readyState == 4) {
            var xmlDoc = request2.responseXML;
            //var intersection  = xmlDoc.documentElement.getElementsByTagName("intersection");
            // displayIntersection(intersection,lat,lng);
        }
    } // function
    request2.send(null);
}

function displayStreetSegments(lines){
    var html = '<table><tr class=restable><th>Street</th><th>highway</th><th>railway</th><th>oneway</th><th>maxspeed</th><th>ref</th></tr>';
    console.log("displayStreetSegments L="+lines.length)
    for (var i = 0; i < lines.length; i++) {
        var name = '?';
        if (lines[i].getElementsByTagName("name")[0].childNodes[0] != null) {
            name = lines[i].getElementsByTagName("name")[0].childNodes[0].nodeValue;
        }
        var id = lines[i].getElementsByTagName("id")[0].childNodes[0].nodeValue;

        var fraddl = '';
        if (lines[i].getElementsByTagName("highway")[0].childNodes[0] != null) {
            fraddl = lines[i].getElementsByTagName("highway")[0].childNodes[0].nodeValue;
        }
        var fraddr = '';
        if (lines[i].getElementsByTagName("railway")[0].childNodes[0] != null) {
            fraddr = lines[i].getElementsByTagName("railway")[0].childNodes[0].nodeValue;
        }
        var toaddl= '';
        if (lines[i].getElementsByTagName("oneway")[0].childNodes[0] != null) {
            toaddl = lines[i].getElementsByTagName("oneway")[0].childNodes[0].nodeValue;
        }
        var toaddr = '';
        if (lines[i].getElementsByTagName("maxspeed")[0].childNodes[0] != null) {
            toaddr = lines[i].getElementsByTagName("maxspeed")[0].childNodes[0].nodeValue;
        }

        var mtfcc = '';
        if (lines[i].getElementsByTagName("ref")[0].childNodes[0] != null) {
            mtfcc = lines[i].getElementsByTagName("ref")[0].childNodes[0].nodeValue;
        }

        if (i % 2== 0) {
            html = html + '<tr>';
        } else {
            html = html + '<tr class=\"odd\">';
        }

        html = html + '<td style="text-align: left; "><a href="javascript:displayLine(' + id + ');">' + name + '</a></td>';
        html = html + '<td class="rightalign">'+ fraddl + '</td><td class="rightalign">' +  fraddr + '</td><td class="rightalign">' + toaddl + '</td><td class="rightalign">' + toaddr +  '</td><td class="rightalign">' + mtfcc + '</td></tr>';
    }

    html = html + '<tr><td colspan=6><small>click on street name to see the segment on the map</small></td></tr>';
    html = html + '</table>';

    document.getElementById("addressDiv").innerHTML = html ;
}