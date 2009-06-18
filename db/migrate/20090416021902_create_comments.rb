class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.references :user
      t.string :description, :size=>255
      t.references :task

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
