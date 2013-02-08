ActiveAdmin.register Street do
  ###has_and_belongs_to_many :rayons
  config.sort_order = "id_asc"
  menu :parent => "City", :label => "Streets"## proc{ I18n.t("City-s") }

  scope :all, :default => true
  #filter :name_rus
  #filter :rayons,:as => :select, :collection => proc{ Rayon.where("parent=2775")}
  #filter :rayons_streets_rayon_id,:label=>"Rayons", :as => :select, :collection => proc{ Rayon.where("parent=2775") }

  #sidebar :street_in_rayons, :partial=>'_street_in_rayons.html'
   sidebar :street_in_rayons do
     render :template=>'admin/_street_in_rayons.html'
   end

  #member_action :rayonname, :method => :get do
  # st = Street.where("id<="+params[:id])
  #
  # ## redirect_to :action => "index"
  #end
  index :as=>:table do |tb|
    column "name(RUS)", :name_rus ,:sortable => false
    column "Rayon_name",:class=>"cell_row",:sortable => false do |st|

      rec = Street.find(st.id).rayons
      if rec != []
        out=''
        rec.each_with_index do |r,i|
          out=out+r.name
          if r != rec.last
            out+=", "
          end
        end
        out
      else
        link_to "???","javascript:alert('add?')",:id=>"rayon_err_"+st.id.to_s,:style=>"color:red"
      end
    end
    column "Lat", :center_lat ,:sortable => false
    column "Lng", :center_lng ,:sortable => false
    default_actions
  end

  controller do
    def scoped_collection
      #if request.url.match(/rayons/) != nil
      if params[:rrr].present?
        #Street.find_by_sql("SELECT s.* FROM streets as s,rayons_streets as rs WHERE s.id=rs.street_id AND rs.rayon_id=2776 ORDER by s.name_rus ASC") #where("id<"+params[:rrr].to_s)#Street.find_by_sql("SELECT s.* FROM streets as s,rayons_streets as rs WHERE s.id=rs.street_id AND rs.rayon_id="+params[:rrr].to_s)#Street.getStreetsInRayon(params[:rayons])
        Street.select("*").from("streets,rayons_streets").where("streets.id=rayons_streets.street_id AND rayons_streets.rayon_id=?",params[:rrr]).order("streets.name_rus")
      else
        Street.select("*")
      end
    end
  end
  #show do
  ##    h2 "Hello!"
  #  st = Street.where("id<=10")
  #end
end

