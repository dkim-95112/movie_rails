class CreateActors < ActiveRecord::Migration
  def up
    create_table :actors, :force => true do |t|
      t.string :name
      t.timestamps
    end
    execute "alter table actors add constraint unique index (name)"
  end

  def down
    execute "drop table actors"
  end
end
