class CreatePatternPauses < ActiveRecord::Migration
  def self.up
    create_table :pattern_pauses, :force => true do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_pauses
  end
end
