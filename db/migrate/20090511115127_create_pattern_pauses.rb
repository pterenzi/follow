class CreatePatternPauses < ActiveRecord::Migration
  def self.up
    create_table :pattern_pauses, :force => true do |t|
      t.string :description

      t.timestamps
    end
    add_index :pattern_pauses, :id
    PatternPause.create(:description=>"Almoço");
    PatternPause.create(:description=>"Fim do expediente")
    PatternPause.create(:description=>"Banheiro")
  end

  def self.down
    drop_table :pattern_pauses
  end
end
