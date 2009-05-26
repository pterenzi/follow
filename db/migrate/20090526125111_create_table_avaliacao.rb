class CreateTableAvaliacao < ActiveRecord::Migration
  def self.up
    create_table :avaliacao do |t|
      t.integer :tarefa_id
      t.integer :user_id
      t.integer :nota
      t.string :comentario
      
      t.timestamps
    end
  end

  def self.down
    drop_table :avaliacao
  end
end
