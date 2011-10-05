class CreateActors < ActiveRecord::Migration
  def up
    create_table :actors, :force => true do |t|
      t.string :name
      t.timestamps
    end
    execute "alter table actors add unique (name)"
  end

  def down
    execute "drop table actors"
  end
end
