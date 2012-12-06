
console.log("aaaa");
cur_rayon_id=0;
rayons_coorditates={};
myPolygon=[];
rayons_coorditates.n_0=[
    [49.976072, 36.210448], //36.210448,49.976072
    [50.032719,36.305205],  // 36.305205,50.032719
    [49.94152, 36.338164] // 36.338164,49.94152
];
//rayons_coorditates.n_0= [ [ 49.9851, 36.2776 ], [ 49.9981, 36.3013 ], [ 50.0062, 36.2928 ], [ 50.0124, 36.2992 ], [ 50.0353, 36.3339 ], [ 50.0249, 36.3677 ], [ 50.0157, 36.3681 ], [ 50.0077, 36.3593 ], [ 49.9958, 36.3735 ], [ 49.9889, 36.3539 ], [ 49.9788, 36.3095 ], [ 49.9848, 36.2989 ], [ 49.9835, 36.2866 ], [ 49.9851, 36.2776 ] ];
function fillPolyFromStr(data){
    var res_str,res_arr;
    var res=[];
    res_str=data.replace("],","];");
    res_arr=res_str.split(";");
    for (var i = 0, l = res_arr.length; i < l; i++) {
       res.push(eval(res_arr[i]));
    }
    return res;
}
function stringify (coords) {
    var res = '';
    if ($.isArray(coords)) {
        res = '[ ';
        for (var i = 0, l = coords.length; i < l; i++) {
            if (i > 0) {
                res += ', ';
            }
            res += stringify(coords[i]);
        }
        res += ' ]';
    } else if (typeof coords == 'number') {
        res = coords.toPrecision(6);
    } else if (coords.toString) {
        res = coords.toString();
    }

    return res;
}
function setCenter() {
    var lat=$("#lat_center").val();
    var long=$("#long_center").val();
    myMap.setCenter([lat,long]);
    // Создаем метку с помощью вспомогательного класса.
   // myCenter = new ymaps.Placemark(lat, long), {
        // Свойства.
        // Содержимое иконки, балуна и хинта.
    //    iconContent: '1',
    //    balloonContent: 'Центр',
    //    hintContent: 'Центр карты'
    //};//, {
        // Опции.
        // Стандартная фиолетовая иконка.
      //  preset: 'twirl#violetIcon'
    //});
   // myMap.geoObjects.add(myCenter);
}
function setPolyOnMap(polygon) {
    myGeometry = {
        type: 'Polygon',
        coordinates: [ polygon
        ]
    };
    myOptions = {
        strokeWidth: 4,
        strokeColor: '#0000FF', // синий
        fillColor: '#FFFF00', // желтый
        opacity: 0.4,//прозрачность
        draggable: true      // объект можно перемещать, зажав левую кнопку мыши
    };
    if (myGeoobject.geometry !=undefined){
        myGeoobject.geometry.remove();
    }
    // Создаем геообъект с определенной (в switch) геометрией.
    myGeoobject = new ymaps.GeoObject({geometry: myGeometry}, myOptions);
    myGeoobject.events.add('geometrychange', function (event) {
        printGeometry(myGeoobject.geometry.getCoordinates());
        rayons_coorditates.n_0=myGeoobject.geometry.getCoordinates();
    });
    myMap.events.add('contextmenu', function (e) {
        var coords = e.get('coordPosition');
        myMap.hint.show(e.get('coordPosition'), 'Координаты:\n'+ coords[0].toPrecision(8)+", "+
            coords[1].toPrecision(8));
    });
    myMap.events.add('actiontick', function (e) {
        var tick = e.get('tick');
        console.log('Now the map is moving to the point (' +
            myMap.options.get('projection').fromGlobalPixels(tick.globalPixelCenter, tick.zoom).join(',') +
            ') during ' + e.get('tick').duration + ' milliseconds');
        $("#lat_center").val(myMap.getCenter()[0]);
        $("#long_center").val(myMap.getCenter()[1]);
    });
    myMap.geoObjects.add(myGeoobject);
    printGeometry(myGeoobject.geometry.getCoordinates());
    myGeoobject.editor.startEditing();

}
function createPoly() {
    console.log('create poly!');
    cur_rayon_id=$('#rayons_name :selected').val();
    rayons_coorditates["n_"+cur_rayon_id]=rayons_coorditates.n_0;
    setPolyOnMap(rayons_coorditates.n_0);
   // myMap.myGeometry.coordinates =rayons_coorditates["n_"+cur_rayon_id];
}
function savePoly() {
    //alert('Hello world!');
    cur_rayon_id=$('#rayons_name :selected').val();
    $.post(
        "rayons_geo/save_poly",
        {coordinates:stringify(rayons_coorditates.n_0),
         rayon_id:cur_rayon_id
        },
        function(data) {
            alert(data);
        }
    )
}
function loadPoly() {
    //alert('Load_poly!');
    cur_rayon_id= $('#rayons_name :selected').val();
    $.post(
        "rayons_geo/load_poly",
        {rayon_id:cur_rayon_id},
        function(data) {
            //alert(data);
            myPolygon=eval(data)[0];//fillPolyFromStr(data);
            //console.log(myPolygon);
            setPolyOnMap(myPolygon);
            rayons_coorditates["n_"+cur_rayon_id]=myPolygon;
        }
    )
}
function makeMapPolygons(p) {
    PolygonCollection=new ymaps.GeoObjectArray()

    mypolygons={}
    myOptions = {
        strokeWidth: 4,
        strokeColor: '#0000FF', // синий
        fillColor: '#FFFF00', // желтый
        opacity: 0.4,//прозрачность
        draggable: false
    };
    //if (myGeoobject.geometry !=undefined){
    //    myGeoobject.geometry.remove();
    //}
    //myMap.geoObjects.remove();
    console.info("p.length="+ p.length)
    for (var i=0; i< p.length;i++) { //p.length
        var correct_polygon=eval(p[i].contur);
        if (p[i].contur=="") continue;
        var myPolygon = new ymaps.Polygon(correct_polygon, {
            hintContent:p[i].name
        }, {
            fillColor: '#6699ff',
            // Делаем полигон прозрачным для событий карты.
            interactivityModel: 'default#transparent',
            strokeWidth: 3,
            opacity: 0.5
        });

//        myGeometry = {
//            type: 'Polygon',
//            coordinates: [ correct_polygon ]
//        };
        console.table(correct_polygon)
        //var myPolygon=new ymaps.GeoObject({geometry: myGeometry},  myOptions);
        var cur_id=p[i].id;
        console.info(cur_id)
        mypolygons[cur_id]=myPolygon;
        console.info("SET for "+cur_id+" l="+ mypolygons[cur_id])
        PolygonCollection.add(mypolygons[cur_id])

    }
    myMap.geoObjects.add(PolygonCollection)
    myMap.setBounds(PolygonCollection.getBounds());
}
function load_rayons_poly(){
    rayons_poly={};
    $.post(
        "rayons_geo/load_rayons_poly",
        {rayon_id:cur_rayon_id},
        function(data) {
             rayons_poly=data;
             console.log(rayons_poly);
             makeMapPolygons(rayons_poly);
        }
    )
}

//---------------------------------MAP-------------------------------
// Как только будет загружен API и готов DOM, выполняем инициализацию
ymaps.ready(init);
myGeometry=myGeoobject={};
function init () {
    myMap = new ymaps.Map("map", {
            center: [49.98, 36.32],
            zoom: 10
        }),
    //--кнопки управления
    myMap.controls
        // Кнопка изменения масштаба
        .add('zoomControl')
        // Список типов карты
        .add('typeSelector')
        // Кнопка изменения масштаба - компактный вариант
        // Расположим её справа
        .add('smallZoomControl', { right: 5, top: 75 })
        // Стандартный набор кнопок
        .add('mapTools');
    /// setPolyOnMap(rayons_coorditates.n_0);
    // Создаем геообъект с определенной (в switch) геометрией.
    //myGeoobject = new ymaps.GeoObject({geometry: myGeometry}, myOptions);

    // При визуальном редактировании геообъекта изменяется его геометрия.
    // Тип геометрии измениться не может, однако меняются координаты.
    // При изменении геометрии геообъекта будем выводить массив его координат.
   // myGeoobject.events.add('geometrychange', function (event) {
   //     printGeometry(myGeoobject.geometry.getCoordinates());
   //     rayons_coorditates.n_0=myGeoobject.geometry.getCoordinates();
   // });

    // Размещаем геообъект на карте
   /// myMap.geoObjects.add(myGeoobject);
    // ... и выводим его координаты.
   /// printGeometry(myGeoobject.geometry.getCoordinates());
    // Подключаем к геообъекту редактор, позволяющий
    // визуально добавлять/удалять/перемещать его вершины.
    //myGeoobject.editor.startEditing();
}

// Выводит массив координат геообъекта в <div id="geometry">
function printGeometry (coords) {
    $('#geometry').html('Координаты: ' + stringify(coords));


}
