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
    action_item do
     # button_to "Load rayons polygons","rayons_geo/load_rayons_poly", :remote =>true, :success => "alert(request)"
      button_to_function "Load rayons polygons", "load_rayons_poly();"
                     #:url => "rayons_geo/load_rayons_poly",
    end
    action_item do
      button_to_function "Load streets", "load_streets();"
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
      def load_rayons_poly
        r_poly=Rayon.select("id,name,contur").where("parent=2775 and contur is not null")
        render :json =>r_poly
      end
      def load_streets
        st=Street.select("id,name_rus,center_lat,center_lng").order("id").limit(params[:start].to_s+",20")
        render :json=>st
      end
      def save_streets
        items=params[:items]
        items.each do |item|
          rs=Rayons_street.new
          item[1]["rayons_id"].each do |r_id|
            rs.rayon_id=r_id
            rs.street_id=item[1]["id"]
            rs.save
          end
        end
        render :text=>items.length
      end
    end
    #---------------------------------------
    sidebar :streets_coordinate_log, :style=>"float:right" do
      form do |f|
        f.label"Start from:"
        f.input :string=>"1",:id=>"start_txt",:size=>10
        f.label "Done:"
        f.input :id=>"done_txt",:id=>"done_txt", :size=>10

      end
      div :class=>"streets_in_work",:id=>"streets_in_work" do
        ul do
          li "Street 1"
          li "Street 2"
          li "Street 3"
        end
      end
    end
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