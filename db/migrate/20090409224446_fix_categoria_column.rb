class FixCategoriaColumn < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :categoria_id, :integer
    remove_column :usuarios, :categorias_id
  end

  def self.down
    remove_column :usuarios, :categoria_id
    add_column :usuarios, :categorias_id
  end
end
