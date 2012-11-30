 ActiveAdmin.register_page "rayons_geo" do
    menu :label => "GEO Rayons", :parent => "Dashboard"
    #form :partial => "form"
    action_item do
     # button_to "Create", "rayons_geo/create_poly", :remote => true, :form => { "data-type" => "json","rayons_coorditates"=>"rayons_coorditates" }
      button_to_function "Create","createPoly();", :class => "action_item"
    end
    action_item do
      #link_to "Save", "#", :onclick =>"alert('Saved!');"
      button_to_function "Save","savePoly();", :class => "action_item"
    end
    action_item do
      #link_to "load", "rayons_geo/load"
      button_to_function "Load","loadPoly();", :class => "action_item"
    end
    # /admin/posts/:id/comments
    controller do
      def create_poly
          render :text=> "Text from create_poly controller"+params.inspect
      end
      def save_poly
        @r=Rayon.find(params[:rayon_id].to_i)
        @r.contur=params[:coordinates]
        @r.save
        render :text=> "Text from save_poly controller"+params.inspect
      end
      def load_poly
        @r=Rayon.find(params[:rayon_id].to_i)
        render :text=> @r.contur
      end
    end
    #---------------------------------------

    content do
      h1 "Rayons GEO"
      #div :class =>"map-geo", :id =>"map"
      #div :id =>"geometry"
      #render :text=> "Text from content"
      #@rayon_names=Rayon.where(:parent =>2775).select("id,name")

      render :template =>"/admin/rayons_geo.html"  # ,:locals =>{:rayon_names=>@rayon_names}
      #button_to "Create-poly", :action => "create_poly", :remote => true, :form => { "data-type" => "json" }
    end
 end