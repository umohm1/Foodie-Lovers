class Review < ActiveRecord::Base
  validates_presence_of :title, :description, :rating
  belongs_to :user
end
