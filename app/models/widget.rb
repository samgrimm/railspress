class Widget < ApplicationRecord
  belongs_to :widgetable, polymorphic: true
  mount_uploader :image, ImageUploader

  def self.by_position
    order('position ASC')
  end
end
