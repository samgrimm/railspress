class AddColorcombosToWebsites < ActiveRecord::Migration[5.0]
  def change
    add_reference :websites, :color_combo, foreign_key: true
  end
end
