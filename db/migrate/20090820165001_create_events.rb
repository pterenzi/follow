class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :date
      t.string :content
      t.integer :user_id
      t.integer :written_by

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
