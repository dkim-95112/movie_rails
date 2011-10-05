class CreateCasts < ActiveRecord::Migration
  def up
    create_table :casts, :id => false, :force => true do |t|
      t.references :actor
      t.references :movie
    end
    execute "alter table casts add unique (movie_id, actor_id)"
    execute "alter table casts add foreign key (movie_id) references movies(id) on delete cascade on update cascade"
    execute "alter table casts add foreign key (actor_id) references actors(id) on delete cascade on update cascade"
  end

  def down
    execute "drop table casts"
  end
end
