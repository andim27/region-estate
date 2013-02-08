/**
 * Created with AMK.
 * User: andrey
 * Date: 30.01.13
 * Time: 10:05
 * To change this template use File | Settings | File Templates.
 */

Planirovka = Backbone.Model.extend({
    urlRoot:App.protocol+App.baseUrl+"haves/planirovki/",
    initialize:function() {
        $("head").append('<link rel="stylesheet" type="text/css" href="/assets/uploadify.css" />')
        $("head").append('<script type="text/javascript" src="/assets/jquery.uploadify.min.js"></script>')
        this.formula_items={'0':["free plan"],'1':["1"],2:["2","1+1"],'3':["3","1+1+1","1+2","2+1"],'4':["4","1+1+1+1","1+3","3+1","2+2"]}
    },
    initUplodify:function(){
        App.uploadify_data.id=App.collections.haves.models[App.main_view.cur_have_item].attributes.id; //--get cur Have id
        var csrf_token = $('meta[name=csrf-token]').attr('content');
        var csrf_param = $('meta[name=csrf-param]').attr('content');
        App.uploadify_data[csrf_token] = encodeURI(csrf_token);
        App.uploadify_data[csrf_param] = encodeURI(csrf_token);

        $('#file_upload').uploadify({
            'buttonText':'Select File-Plan',
            'width'    : 100,
            'height'   :20,
            'swf'      : '/assets/uploadify.swf',
            'uploader' :App.protocol+App.baseUrl+'haves/uploadify',
            'formData' : App.uploadify_data, //--GET FROM App erb format first after js
            'onUploadSuccess' : function(file, data, response) {
                console.log('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);
                data=JSON.parse(data)
                App.models.planirovka.setPlanImage(data.plan_image_url)
                //$(this).setPlanImage(data.plan_image_url)

            },
            'onUploadError' : function(file, errorCode, errorMsg, errorString) {
                alert('ERROR - the file ' + file.name + ' could not be uploaded: ' + errorString);
            }
        });
            // Put your options here

    },
    getContent:function(){ //this.get("id")
      var data_tpl={
          room: this.get("id"),
          files: this.get("files")
      }
      return HB.compile($("#slider-content").html())(data_tpl);
    },
    getFormulaHTML:function(){
        try {
        var room=this.get("id")
        if ((room != undefined) &&(room>=0)&&(room<=4)) {

        } else {
            room=0
        }
        } catch (e) { console.log(e);room=0}
        var f_arr=this.formula_items[String(room)]
        option_str="<option value=0 >select item</option>"
        for (var i=0;i<f_arr.length;i++) {
            option_str=option_str+"<option value="+i+" >"+f_arr[i]+"</option>"
        }
      return '<label>Combined-Separated</label><select id="plan_rooms_select" style="dislay:inline;margin-left:5px">'+option_str+'</select> ';
    },
    saveToHaveModel: function(){
        var saved_str=""
        if ($("#plan_rooms_select").val() !=0) {
            App.collections.haves.models[App.main_view.cur_have_item].attributes.plan_rooms=$("#plan_rooms_select :selected").text()
            saved_str=saved_str+" formula saved \n"
        }
        if ($("#main_plan_img").length !=0){
            App.collections.haves.models[App.main_view.cur_have_item].attributes.plan_image=$("#main_plan_img").attr("src")
            saved_str=saved_str+" image plan saved \n"
        }
        alert("Saved: "+saved_str);
    },
    setPlanImage:function(url_str){
        $("#main_plan").html('<img id="main_plan_img" width=\'100%\' height=\'100%\'  src='+url_str+'></img>')
    },
    show:function(params) {

        console.log(params)
        this.title_win="Planirovka:"
        if (params.room != undefined){
            this.title_win=this.title_win+params.room+" "+"room";
            this.set({id:params.room})
        }else {
            this.title_win=title_win+" ???";

        }
        if ($('#m_win').length<=0){
//           $("#main_content").append("<div id='m_win'></div>")
            $("body").append("<div id='m_win'></div>")
        }
        // this.showWindow()
        this.fetch().done(function(res){
            //  res format  ["house_12_chex.gif", "house_14_kirp_pr_Gagarina.gif", "house_14_kirp_ulutch_plan.gif"]
            App.models.planirovka.set({files:res})
            App.models.planirovka.showWindow()
        }).error(function(e){alert("Planirovki error:"+e)})

    },
    showWindow:function(){
        $('#m_win').dialog({
            width:600,
            height:400,
            title:this.title_win,
            inline:true,
            shadow:true,
            content:this.getContent(),
            toolbar: [
                {
                text:'Save',
                iconCls:'icon-save',
                handler:function(){
                   App.models.planirovka.saveToHaveModel()
                }}



            ],
            modal:true
        });

        var y=parseInt($(document).height()*0.1)+"px"
        var tools_width=parseInt($(".dialog-toolbar").width()*0.8)+"px"
        $(".panel.window").css("top",y)
        $('#m_win').dialog('open')
        //-----append plan-formula select------------------------------------------
        $(".dialog-toolbar table tr").append( '<td>'+this.getFormulaHTML()+'</td>')
        //-----append UPLODIFY------------------------------------------------------
        $(".dialog-toolbar table tr").append( '<td><input type="file" name="file_upload" id="file_upload" /></td>')
        this.initUplodify()

        $(".window-shadow").css("top",y)
        $(".dialog-toolbar table").css({"width":tools_width})
        console.log("PLAN x="+$(".panel.window").css("left")+"  y="+$(".panel.window").css("top"))

        var plan_url=App.collections.haves.models[App.main_view.cur_have_item].get("plan_image").url
        if (plan_url != undefined) {
            this.setPlanImage(plan_url)
        }
    }

 }
)

