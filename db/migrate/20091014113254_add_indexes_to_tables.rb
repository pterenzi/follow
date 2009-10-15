class AddIndexesToTables < ActiveRecord::Migration
  def self.up
     add_index :pauses, :task_id
    # add_index :messages, :written_by
     add_index :messages, :user_id
     add_index :evaluations, :user_id
     add_index :evaluations, :task_id
     add_index :comments, :user_id
     add_index :comments, :task_id
     add_index :projects_users, [:project_id, :user_id]
     add_index :tasks, :project_id
     add_index :tasks, :requestor_id
     add_index :tasks, :user_id
     add_index :events, :user_id
     add_index :users, :category_id
   #  add_index :users, :company_id
     add_index :user_groups_users, [:user_group_id, :user_id]
     
     add_index :pauses, :id
     add_index :user_groups, :id
     add_index :pattern_pauses, :id
     add_index :messages, :id
     add_index :comments, :id
     add_index :projects, :id
     add_index :companies, :id
     add_index :categories, :id
     add_index :tasks, :id
     add_index :events, :id
     add_index :users, :id
     
   end

   def self.down
     remove_index :pauses, :task_id
    # remove_index :messages, :written_by
     remove_index :messages, :user_id
     remove_index :evaluations, :user_id
     remove_index :evaluations, :task_id
     remove_index :comments, :user_id
     remove_index :comments, :task_id
     remove_index :projects_users, :column => [:project_id, :user_id]
     remove_index :tasks, :project_id
     remove_index :tasks, :requestor_id
     remove_index :tasks, :user_id
     remove_index :events, :user_id
     remove_index :users, :category_id
  #   remove_index :users, :company_id
     remove_index :user_groups_users, :column => [:user_group_id, :user_id]
     
     remove_index :pauses, :id
     remove_index :user_groups, :id
     remove_index :pattern_pauses, :id
     remove_index :messages, :id
     remove_index :comments, :id
     remove_index :projects, :id
     remove_index :companies, :id
     remove_index :categories, :id
     remove_index :tasks, :id
     remove_index :events, :id
     remove_index :users, :id
    
   end
 
end
