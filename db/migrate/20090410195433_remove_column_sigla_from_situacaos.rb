class RemoveColumnSiglaFromSituacaos < ActiveRecord::Migration
  def self.up
    remove_column :situacaos, :sigla, :string
  end

  def self.down
    add_column :situacaos, :sigla, :string
  end
end
