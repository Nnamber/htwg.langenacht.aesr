class Course < ActiveRecord::Base
  has_many :topics
  
  validates :topic, presence:true
  has_attached_file :xmlfile
end
