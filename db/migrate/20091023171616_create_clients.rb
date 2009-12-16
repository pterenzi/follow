class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.date :start_at
      t.boolean :active
      t.date :valid_until
      t.integer :users_license

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
