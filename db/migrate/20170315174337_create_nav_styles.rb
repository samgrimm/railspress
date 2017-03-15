class CreateNavStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :nav_styles do |t|
      t.string :name

      t.timestamps
    end
  end
end
