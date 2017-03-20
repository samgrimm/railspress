class CreateWidgets < ActiveRecord::Migration[5.0]
  def change
    create_table :widgets do |t|
      t.string :type
      t.belongs_to :widgetable, polymorphic: true
      t.text :content
      t.string :title
      t.index :widgetable_type
      t.index :widgetable_id
      t.timestamps
    end
  end
end
