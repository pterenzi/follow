class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.boolean :active, :default=>true

      t.timestamps
    end
        
    add_column :users, :company_id, :integer
    add_index :users, :company_id
  end

  def self.down
    remove_index :users, :company_id
    remove_column :users, :company_id
    drop_table :companies
  end
end
