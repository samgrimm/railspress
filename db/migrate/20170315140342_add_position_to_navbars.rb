class AddPositionToNavbars < ActiveRecord::Migration[5.0]
  def change
    add_column :navbars, :position, :integer, default: 0
  end
end
