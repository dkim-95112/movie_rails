class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies, :force => true do |t|
      t.string :title
      t.timestamps
    end
    execute "alter table movies add unique (title)"
  end

  def down
    execute "drop table movies"
  end
end
