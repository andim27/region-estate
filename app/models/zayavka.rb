class Zayavka <  ActiveRecord::Base
  # To change this template use File | Settings | File Templates.
  has_many :have
  has_many :want

  belongs_to :contact
  belongs_to :info_source
  belongs_to :info_type

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