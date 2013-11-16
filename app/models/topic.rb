class Topic < ActiveRecord::Base
  has_many :questions
  belongs_to :course
end
