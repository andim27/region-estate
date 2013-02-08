class Have < ActiveRecord::Base
  #attr_accessible #

  belongs_to :rayon, :foreign_key => :rayon_id   ###,  :polymorphic => true
  belongs_to :street,:foreign_key => :street_id
  belongs_to :kurs
  belongs_to :obj,   :foreign_key => :obj_id
  belongs_to :state
  belongs_to :card,  :foreign_key => :card_id
  belongs_to :zayavka
  belongs_to :info_source

  scope :haves_relation_name, lambda {|z_id|
    #begin
    #if ActiveRecord::Base.connection_config[:adapter].include?("mysql")
         #----(SELECT group_concat(convert(dp.name,char(15)))as str FROM dop_params as dp WHERE ( haves.dop_param_1 LIKE concat('%',cast(dp.id as char),'%') ))
         Have.select("haves.*,objs.name as obj_name,states.name as state_name,TRIM(rayons.name) as rayon_name,TRIM(streets.name_rus) as street_name ")
         .joins("LEFT JOIN objs    ON objs.id=haves.obj_id")
         .joins("LEFT JOIN states  ON states.id=haves.state_id")
         .joins("LEFT JOIN rayons  ON rayons.id=haves.rayon_id")
         .joins("LEFT JOIN streets ON streets.id=haves.street_id")
         .where('haves.zayavka_id=?',z_id)
   # end
    #if ActiveRecord::Base.connection_config[:adapter].include?("PostgreSQL")
    #
    #end
    #end
  }

  mount_uploader :plan_image, PlanirovkaUploader

end
