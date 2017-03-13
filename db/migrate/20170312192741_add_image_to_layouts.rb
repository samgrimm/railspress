class AddImageToLayouts < ActiveRecord::Migration[5.0]
  def change
    add_column :layouts, :image, :string
  end
end
