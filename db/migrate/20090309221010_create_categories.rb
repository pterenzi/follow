class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name , :limit=>32
      t.timestamps
    end
    Category.create(:name=>"Gestor");
    Category.create(:name=>"Adminstrador")
    Category.create(:name=>"Usuário")
  end
  
  def self.down
    drop_table :categories  
  end
end
