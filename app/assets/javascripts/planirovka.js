/**
 * Created with AMK.
 * User: andrey
 * Date: 30.01.13
 * Time: 10:05
 * To change this template use File | Settings | File Templates.
 */
Planirovka = Backbone.Model.extend({
    urlRoot:App.protocol+App.baseUrl+"haves/planirovki/",
    getContent:function(){
      var data_tpl={}
      return HB.compile($("#slider-content").html())(data_tpl);
    },
    getFormulaHTML:function(){
      return '<label>Combined-Separated</label><select style="dislay:inline;float:right;margin-left:5px"><option>1+1</option></select> ';
    },
    showWindow:function(){
        $('#m_win').dialog({
            width:600,
            height:400,
            title:title_win,
            inline:true,
            shadow:true,
            content:this.getContent(),
            toolbar: [{
                text:'Help',
                iconCls:'icon-help',
                handler:function(){
                    alert('help')
                }
            },'-',{
                text:'Save',
                iconCls:'icon-save',
                handler:function(){
                    alert('save')
                }},
                {
                    text:this.getFormulaHTML()
                }
            ],
            modal:true
        });
        var y=parseInt($(document).height()*0.1)+"px"
        var tools_width=parseInt($(".dialog-toolbar").width()*0.5)+"px"
        $(".panel.window").css("top",y)
        $('#m_win').dialog('open')
        $(".window-shadow").css("top",y)
        $(".dialog-toolbar table").css({"width":tools_width})
        console.log("PLAN x="+$(".panel.window").css("left")+"  y="+$(".panel.window").css("top"))
    },
    show:function(params) {
       console.log(params)
       var title_win="Planirovka:"
       if (params.room != undefined){
           title_win=title_win+params.room+" "+"room";
       }else {
           title_win=title_win+" ???";
           this.set({id:room})
       }
       if ($('#m_win').length<=0){
//           $("#main_content").append("<div id='m_win'></div>")
             $("body").append("<div id='m_win'></div>")
       }
        this.fetch().succes(function(){
            this.showWindow()
        }).error(function(e){alert("Planirovki error:"+e)})

   }
 }
)

