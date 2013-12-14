class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :topic
  
  validates :name, presence:true
  validates :body, presence:true
end
