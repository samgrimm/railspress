class AddImageToWidgets < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :image, :string
  end
end
