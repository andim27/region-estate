ActiveAdmin.register Have do
  menu :parent =>  "Zayavki", :label => "Have",:priority => 2
  ##belongs_to :zayavka    :label => I18n.t('obmen')
  filter :obj_id, :label =>"Object"
  filter :room
  filter :rayon_id,:label=>"Rayon", :collection =>proc{Rayon.where("parent=2775")}
  filter :street_id
  filter :floor
  filter :s_all
  filter :sell_want, :as=> :check_boxes, :collection => ["No","Yes!"]


  index :as=>:table do |tb|
    selectable_column
    column "Have want",:sortable => :id do |rec|

       #" id="+rec.id.to_s+", "+rec.obj.name+", room:"+rec.room.to_s+" Rayon: "+Have.find(rec.id).rayon.name+" tel:"+rec.zayavka.tel_1
       #items=Zayavka.getHaveWant(rec.id)
       #if items.size >0
       render :template=>"admin/obmen_view.html", :locals =>{:items=>Zayavka.getHaveWant(rec.id)}
       #end
    end
    #column "Want" do  |rec|
    #    "want "+rec.obj.name.to_s
    #end
    default_actions

  end

  controller do
    def new
      new! do |format|
        format.html { render :partial => 'admin/class_name/new'  }
        ## render active_admin_template('edit.html.arb'), :layout => false
      end
    end
  end
end