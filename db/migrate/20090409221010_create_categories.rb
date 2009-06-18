class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name , :limit=>32
      t.references :user
      t.timestamps
    end
    Categories.create(:name=>"Gestor");
    Categories.create(:name=>"Adminstrador")
    Categories.create(:name=>"Usuário")
  end
  
  def self.down
    drop_table :categories  
  end
end
