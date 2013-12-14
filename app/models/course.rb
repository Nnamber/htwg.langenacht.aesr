class Course < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  
  validates :topic, presence:true
end
