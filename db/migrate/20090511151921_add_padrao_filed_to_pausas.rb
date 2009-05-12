class AddPadraoFiledToPausas < ActiveRecord::Migration
  def self.up
    add_column :pausas, :padrao, :boolean
    add_column :pausas, :pausa_padrao_id, :integer
  end

  def self.down
    remove_column :pausas, :padrao
    remove_column :pausas, :pausa_padrao_id
  end
end
