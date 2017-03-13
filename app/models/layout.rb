class Layout < ApplicationRecord
  has_many :pages

  mount_uploader :image, ImageUploader
  mount_uploader :document, StylesUploader
  mount_uploader :sheet, StylesUploader
end
