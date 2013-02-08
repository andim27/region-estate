class Zayavka <  ActiveRecord::Base
  # To change this template use File | Settings | File Templates.
  has_many :have,:dependent => :delete_all
  has_many :want,:dependent => :delete_all

  belongs_to :contact
  belongs_to :info_source
  belongs_to :info_type
  belongs_to :status
  scope :fields_relation_name, lambda {|id|
   # Zayavka.select("z.*,inf.name as info_sources_name,inf_type.name as info_type_name ,st.name as status_name,cnt.name as contact_name")
   # .from("zayavkas as z,info_sources as inf,info_types as inf_type,statuses as st,contacts as cnt")
   # .where("z.id=? AND z.info_source_id=inf.id AND z.info_type_id = inf_type.id AND z.status_id = st.id AND z.contact_id = cnt.id",id)
   #    #.from('zayavkas,info_sources,info_types,statuses,contacts')
    Zayavka.select(
    'zayavkas.*,info_sources.name as  info_source_name,info_types.name as info_type_name,statuses.name as status_name,contacts.name as contant_name')
    .joins("LEFT OUTER JOIN info_sources ON info_sources.id=zayavkas.info_source_id")
    .joins("LEFT OUTER JOIN info_types   ON info_types.id=zayavkas.info_type_id ")
    .joins("LEFT OUTER JOIN statuses     ON statuses.id=zayavkas.status_id ")
    .joins("LEFT OUTER JOIN contacts     ON contacts.id=zayavkas.contact_id ")
    .where('zayavkas.id=?',id)
  }
  scope :from_people, lambda {
    Zayavka.select("z.*").from("zayavkas as z,info_sources as inf").where("z.info_source_id=inf.id AND inf.info_type=?",1) ##.order('z.id asc')
  }
  scope :from_internet, lambda {
    Zayavka.select("z.*").from("zayavkas as z,info_sources as inf").where("z.info_source_id=inf.id AND inf.info_type=?",2) ##.order('z.id asc')
  }
  scope :from_agency,   lambda {
    Zayavka.select("z.*").from("zayavkas as z,info_sources as inf").where("z.info_source_id=inf.id AND inf.info_type=?",3) ##.order('z.id asc')
  }
  scope :today, lambda {where("created_at=?",Time.now)}
  scope :n_day_before, lambda { |time| where("created_at < ?", time) }


  def self.getHaveWant (h_id)
    hh=Have.find(h_id)
    items={}
    if hh.id==hh.top_variant_id
      z=hh.zayavka
      h=Have.where("zayavka_id=?",hh.zayavka_id)
      w=Want.where("zayavka_id=?",hh.zayavka_id)
      items={:have_item=>h,
             :want_item=>w,
             :zayavka_item=>z,
      }
    end
    items
  end
end