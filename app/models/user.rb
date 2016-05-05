class User < ActiveRecord::Base
  has_secure_password

  has_many :trips
  has_many :destinations, :through => :trips
  has_many :attractions, :through => :trips
  #has many reviews??? through trips???
end
