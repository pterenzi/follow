class AddReinicioToPausa < ActiveRecord::Migration
  def self.up
    add_column :pausas, :reinicio, :datetime
  end

  def self.down
    remove_column :pausas, :reinicio
  end
end
