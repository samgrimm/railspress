class AddPositionToWidgets < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :position, :integer
  end
end
