class Rayon < ActiveRecord::Base
  self.table_name = "rayons"
  ###attr_accessible :id, :name, :parent, :city_id, :level
  belongs_to :city

  has_and_belongs_to_many :streets
  has_many :market_prices
  has_one  :have
  has_one  :want
end

#class Member < ActiveRecord::Base
#  has_many :outgoing_messages, :class_name  => "Message",
#           :foreign_key => :message_from_id
#  has_many :incoming_messages, :class_name  => "Message",
#           :foreign_key => :message_to_id
#end
#
#
#class Message < ActiveRecord::Base
#  belongs_to :sender, :class_name  => "Member",
#             :foreign_key => :message_from_id
#  belongs_to :receiver, :class_name  => "Member",
#             :foreign_key => :message_to_id
#end
#class Post < ActiveRecord::Base
#  has_many :user_posts
#  has_many :users, :through => :user_posts
#end
#
#class User < ActiveRecord::Base
#  has_many :user_posts
#  has_many :posts, :through => :user_posts
#end
#
#class UserPost < ActiveRecord::Base
#  belongs_to :user # foreign_key is user_id
#  belongs_to :post # foreign_key is post_id
#end