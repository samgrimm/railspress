class Widget < ApplicationRecord
  belongs_to :widgetable, polymorphic: true

  def self.by_position
    order("position ASC")
  end
end
