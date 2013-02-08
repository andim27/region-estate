/**
 * Created with Amk.
 * User: andrey
 * Date: 04.02.13
 * Time: 20:23
 * To change this template use File | Settings | File Templates.
 */
Map = Backbone.Model.extend({
    //dom_id:"",
    defaults:{
      city_name:"Харьков",
      dom_id:"",
      rayon_id:0,
      street_id:0,
      street_name:"",
      house_n:"",
      gps_lat:0,
      gps_lng:0,
    },
    initialize:function(){
       $("head").append('<script type="text/javascript" src="http://api-maps.yandex.ru/2.0/?load=package.full,util.json&lang=ru-RU">')

   },
   geoShow:function(){
       var point_str=App.models.map.get('city_name')+" "+App.models.map.get('street_name')+" "+App.models.map.get('house_n')
       var kind_str='street'
       if ((App.models.map.get('house_n') != "")&&(App.models.map.get('street_name') != "")){ //--street_house
           kind_str='house'
       }
       if (App.models.map.get('street_name').search(/select/) >= 0){ //---only rayon
           point_str=App.models.map.get('city_name')+App.models.map.get('rayon_name')
           kind_str='district'
       }
       var myGeocoder = ymaps.geocode(point_str);
       console.info(point_str)
       myGeocoder.then(
           function (res) {
               console.info("res")
               console.info(res)
               var coords = res.geoObjects.get(0).geometry.getCoordinates();
               var myGeocoder = ymaps.geocode(coords, {kind: kind_str});
               myGeocoder.then(
                   function (res) {
                       var street = res.geoObjects.get(0);
                       var name = street.properties.get('name');
                       //myMap.geoObjects.add(res.geoObjects);
                       var myCoords = res.geoObjects.get(0).geometry.getCoordinates();
                       //myMap.geoObjects.remove()
                       myMap.geoObjects.add(
                           new ymaps.Placemark(myCoords,
                               {iconContent: name+"("+myCoords[0].toPrecision(5)+","+myCoords[1].toPrecision(5)+")"},
                               {preset: 'twirl#greenStretchyIcon'}
                           )
                       );
                       //var myButton = new ymaps.control.Button('<b>'+myCoords+'<b>');
                       //myMap.controls.add(myButton);
                       //myMap.setBounds(myMap.geoObjects.getBounds())
                       myMap.setCenter(myCoords);
                   }
               );
//                 var nearest = res.geoObjects.get(0);
//                 var name = nearest.properties.get('name');
//                 nearest.properties.set('iconContent', name);
//                 nearest.options.set('preset', 'twirl#redStretchyIcon');
//               myMap.geoObjects.add(res.geoObjects);
           },
           function (err) {
               alert('Карта:Ошибка поиска данных: '+point_str);
           })
   },
   initMap:function(){
       console.info(this)
       console.info("b)initMap...this.dom_id="+App.models.map.get('dom_id'))

       window.myMap = new window.ymaps.Map(App.models.map.get('dom_id'), {
           center: [49.98, 36.32],
           zoom: 14,
           behaviors: ['ruler', 'scrollZoom'],
       });
       window.myMap.controls.add(
           new ymaps.control.ZoomControl()
       );
       myMap.controls.add('mapTools');
       myMap.controls.add('searchControl');
       console.info("e)initMap..."+window.myMap)
       $("#"+App.models.map.get('dom_id')).show()
       window.setTimeout("App.models.map.geoShow()", 1000);
   },
   show:function(dom_id,params){
       this.dom_id=dom_id
       this.set({'dom_id':dom_id})
       if (params != undefined){
           this.set({
               'city_name':params.city_name,
               'rayon_id':params.rayon_id,
               'street_id':params.street_id,
               'street_name':params.street_name,
               'house_n':params.house_n})
       }
       console.log(" show this.dom_id="+this.dom_id)
       var map_el=$("#"+dom_id);
       console.info("Map map_el="+map_el.attr("id"))
       console.info(map_el)
       if (map_el.find('ymaps').size() <=0) {
           //--link yamp----
           console.info("link yamp...")
           map_el.show()
           window.ymaps.ready(this.initMap);
       } else if (map_el.is(':visible')==true){
                    map_el.hide()
                  } else {
                    map_el.show()
                    this.geoShow()
                  }
   }
})