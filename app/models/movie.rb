class Movie < ActiveRecord::Base
  has_many :casts
  has_many :actors, :through => "casts"
  validates_uniqueness_of :title
end
