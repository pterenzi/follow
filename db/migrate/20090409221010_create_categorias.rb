class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias, :force => true do |t|
      t.string :nome , :limit=>32
      t.references :user
      t.timestamps
    end
    Categoria.create(:nome=>"Gestor");
    Categoria.create(:nome=>"Adminstrador")
    Categoria.create(:nome=>"Usuário")
  end
  
  def self.down
    drop_table :categorias  
  end
end
