class CreateTableAvaliacao < ActiveRecord::Migration
  def self.up
    create_table :avaliacaos, :force => true do |t|
      t.references :task
      t.references :user
      t.integer :nota
      t.string :comentario_avaliacao
      t.string :comentario_recusa_user
      t.boolean :recusada, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :avaliacaos
  end
end
