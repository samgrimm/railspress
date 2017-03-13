class CreateColorCombos < ActiveRecord::Migration[5.0]
  def change
    create_table :color_combos do |t|
      t.string :name

      t.timestamps
    end
  end
end
