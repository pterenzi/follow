class AddUserIdToComentario < ActiveRecord::Migration
  def self.up
    add_column :comentarios, :user_id, :integer
  end

  def self.down
    remove_column :comentarios, :user_id
  end
end
