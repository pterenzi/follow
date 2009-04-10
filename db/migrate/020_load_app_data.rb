require 'active_record/fixtures'

class LoadAppData < ActiveRecord::Migration
  def self.up

    down

    directory = File.join(File.dirname(__FILE__), "dev_data")
    Fixtures.create_fixtures(directory, "categorias")
    

  end

  def self.down
    
    Categoria.delete_all
    
  end
end
