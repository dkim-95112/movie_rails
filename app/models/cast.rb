class Cast < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
  validates_uniqueness_of :actor_id, :scope => :movie_id
end
