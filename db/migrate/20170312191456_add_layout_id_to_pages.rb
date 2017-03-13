class AddLayoutIdToPages < ActiveRecord::Migration[5.0]
  def change
    add_reference :pages, :layout, foreign_key: true
  end
end
