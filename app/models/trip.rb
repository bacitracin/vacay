class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :destination
  has_many :attractions
  has_many :reviews, :through => :attractions
  
end
 