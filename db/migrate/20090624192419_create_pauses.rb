class CreatePauses < ActiveRecord::Migration
  def self.up
    create_table :pauses, :force => true do |t|
      t.datetime :date
      t.references :task
      t.string :justification
      t.boolean :accepted
      t.string :comment_requestor
      t.datetime :restart
      t.boolean :pattern
      t.references :pattern_pause
      t.references :user
      t.references :client
      t.timestamps
    end
    add_index :pauses, :id
    add_index :pauses, :task_id
    add_index :pauses, :client_id
  end

  def self.down
    drop_table :pauses
  end
end
