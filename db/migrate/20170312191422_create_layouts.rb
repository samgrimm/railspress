class CreateLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :layouts do |t|
      t.string :name
      t.text :document
      t.text :sheet

      t.timestamps
    end
  end
end
