class InfoSource < ActiveRecord::Base
 belongs_to  :Contact
 has_many  :have

 scope :from_people, lambda {where("info_type=1")}
 scope :from_internet, lambda {where("info_type=2")}
 scope :from_agency,   lambda {where("info_type=3")}
end
