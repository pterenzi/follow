class CreateEvaluations < ActiveRecord::Migration
  def self.up
    create_table :evaluations, :force => true do |t|
      t.references :task
      t.references :user
      t.integer :grade
      t.string :comment
      t.string :user_comment
      t.boolean :refused, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :evaluations
  end
end
