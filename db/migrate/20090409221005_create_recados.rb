class CreateRecados < ActiveRecord::Migration
  def self.up
    create_table :recados, :force => true do |t|
      t.integer :escrito_por
      t.integer :para
      t.timestamps
    end
  end
  
  def self.down
  drop_table :recados  
  end
end
