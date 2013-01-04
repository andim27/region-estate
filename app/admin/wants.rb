ActiveAdmin.register Want do
  menu :parent =>  "Zayavki", :label => "Want" #,:priority => 2

  config.sort_order = "id_asc"
  scope :all, :default => true

  filter :id
  filter :obj_id,:label=>"Objects"
  filter :room
  filter :rayon_id
  filter :price
  filter :dop

  index :as=>:table do
      selectable_column
      column "id",:sortable => :id
      column :created_at,:sortable => :created_at,:label=>"Date"

      column "Tel" do |rec|
         span "tel_1:"+rec.tel_1  if rec.tel_2 !=""
         br
         span "tel_2:"+rec.tel_2  if rec.tel_2 !=""
      end
      column "What" do |rec|
        span rec.obj.name
        br
        span ((rec.room ==nil) ?"":rec.room.to_s)+"-room"
      end
      column "Where" do |rec|
        if rec.rayon != nil
          span rec.rayon.name
        end
      end
      column "Price" do |rec|
        rec.price.to_s if rec.price !=0
      end
      column "Dopolnenie",:dop
      default_actions
  end
end