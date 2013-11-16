class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :topic
  
  validates :name, presence:true
  validates :body, presence:true
end
