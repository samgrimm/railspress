class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :status
      t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
