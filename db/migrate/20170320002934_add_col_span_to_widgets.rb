class AddColSpanToWidgets < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :col_span, :string
  end
end
