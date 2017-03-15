class AddNavStyleToNavbars < ActiveRecord::Migration[5.0]
  def change
    add_reference :navbars, :nav_style, foreign_key: true
  end
end
