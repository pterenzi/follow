class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks, :force => true do |t|

    t.references :project 
    t.references :user
    t.references :requestor
    t.string :description,:size=>255
    t.integer :estimated_time , :limit=>4, :null=>false
    t.boolean :user_alert, :default=>false
    t.boolean :requestor_alert, :default=>false
    t.datetime :end_at
    t.string :comment_end_user
    t.string :comment_end_requestor
    t.boolean :refused, :default=>false
    t.boolean :has_comment, :default=>false
    t.timestamps

    end
  end

  def self.down
    drop_table :tasks  
  end
end
