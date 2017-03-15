class CreateNavbars < ActiveRecord::Migration[5.0]
  def change
    create_table :navbars do |t|
      t.string :title
      t.string :style
      t.references :website, foreign_key: true

      t.timestamps
    end
  end
end
