class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :navbar, foreign_key: true
      t.references :page, foreign_key: true
      t.string :display_name

      t.timestamps
    end
  end
end
