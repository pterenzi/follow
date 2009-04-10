class AddLoginToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :login, :string, :limit=>'16'
    add_column :usuarios, :hashed_password, :string
    add_column :usuarios, :salt, :string
  end

  def self.down
    remove_column :usuarios, :salt
    remove_column :usuarios, :hashed_password
    remove_column :usuarios, :login
  end
end
