class Contact < ActiveRecord::Base
  has_many   :info_sources
  belongs_to :have
end
