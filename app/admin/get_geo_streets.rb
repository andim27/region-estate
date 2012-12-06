 ActiveAdmin.register_page "get_geo_streets" do
    menu :label => "GetGeoStreets", :parent => "Dashboard"
    controller do
       def get_streets
           str=Street.select("id,name_rus").order("name_rus asc").limit(params[:start]+",10")
           render :json=>str
       end
      def save_streets
        items=params[:items]
        items.each do |item|
          rec=Street.find(item[1]["id"])
          rec.update_attributes( {:center_lat => item[1]["lat"], :center_lng => item[1]["lng"]})
          #@out=item.inspect
          Rails.logger.info item[1]["name_rus"]+" "+item[1]["lat"]+" " +item[1]["lng"]
        end
        render :json=>params[:items]
      end
    end

    action_item do
      link_to "View Site", "/"
    end
    action_item do
      #link_to "View Streets", "/streets"
      button_to_function "start get streets","getStreets(1);"
    end
    sidebar :streets_coordinate_log do
      form do |f|
        f.label"Start from:"
        f.input :string=>"1",:id=>"start_txt",:size=>10
        f.label "Done:"
        f.input :id=>"done_txt",:id=>"done_txt", :size=>10

      end
      div :class=>"streets_in_work",:id=>"streets_in_work" do
        ul do
          li "Rings call"
          li "Kind of work"
          li "Statistics"
        end
      end
    end
    content do
      h1 "Get Geo Streets"
      div :id=>"map", :style=>"width: 80%; height: 400px; position: relative; background-color: rgb(229, 227, 223); overflow: hidden;"
      div :id=>"address"
      div :id=>"addressDiv"
      #show do |street|
      #  panel "Street details" do
      #    attributes_table_for Street, :first_name
      #  end
      #end
    end

 end