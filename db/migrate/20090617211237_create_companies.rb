class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.boolean :active, :default=>true
      t.references :client
      t.timestamps
    end
    add_index :companies, :id    
    add_index :companies, :client_id
  end

  def self.down
    drop_table :companies
  end
end
