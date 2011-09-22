class Actor < ActiveRecord::Base
  has_many :casts
  has_many :movies, :through => "casts"
  validates_uniqueness_of :name
end
