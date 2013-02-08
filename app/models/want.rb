class Want < ActiveRecord::Base
  belongs_to :zayavka
  belongs_to :rayon
  belongs_to :obj,   :foreign_key => :obj_id
  belongs_to :contact
  #has_many   :wish_list,:class_name => "WishList",:conditions => "Want.id = WishList.want_id"
  has_many   :wish_list, :dependent => :delete_all, :finder_sql => proc {"SELECT wl.* FROM wish_lists as wl,wants as w WHERE wl.want_id=w.id AND w.id=#{id} ORDER by want_cnt"}

  before_destroy { |record| WishList.destroy_all "want_id = #{record.id}"   }

  #attr_accessible :wishlist

  #def wishlist
  # @@wishlist=self.wish_list
  #end
end
