class Topic < ActiveRecord::Base
  has_many :question
  belongs_to :course
end
