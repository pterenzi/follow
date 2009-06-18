class CreatePauses < ActiveRecord::Migration
  def self.up
    create_table :pauses, :force => true do |t|
      t.datetime :data
      t.references :task
      t.string :justification
      t.boolean :accepted
      t.string :comment_requestor
      t.datetime :restart
      t.boolean :pattern
      t.references :pattern_pause
      t.timestamps
    end
  end

  def self.down
    drop_table :pauses
  end
end
