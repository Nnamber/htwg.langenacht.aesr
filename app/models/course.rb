class Course < ActiveRecord::Base
  has_many :topics
  
  validates :topic, presence:true
end
