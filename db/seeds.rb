# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
movies = Movie.create [
  {title:'Star Trek (2009)'},
  {title:'Star Trek (1966)'},
]
actors = Actor.create [
  {name:'Chris Pine'},
  {name:'Zachary Quinto'},
  {name:'Leonard Nimoy'},
  {name:'William Shatner'},
]

def movie_cast( movie_title, actor_names)
  [Movie.where('title = ?', movie_title).first].map { |movie|
    Actor.where(:name => actor_names).all.map { |actor|
      {movie_id: movie.id, actor_id: actor.id}
    }
  }
end

casts = Cast.create [
  movie_cast( 'Star Trek (2009)', ['Chris Pine', 'Zachary Quinto', 'Leonard Nimoy'] ),
  movie_cast( 'Star Trek (1966)', ['William Shatner', 'Leonard Nimoy'] ),
]
