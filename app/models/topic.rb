class Topic < ActiveRecord::Base
  has_many :questions
  belongs_to :course
  
  validates :name, presence:true
end
