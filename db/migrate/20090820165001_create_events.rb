class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :event_type
      t.string :content
      t.integer :user_id
      t.integer :written_by

      t.timestamps
    end
    add_index :events, :id
    add_index :events, :user_id
  end

  def self.down
    drop_table :events
  end
end
