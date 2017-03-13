class Website < ApplicationRecord
  belongs_to :user
  has_many :pages
  belongs_to :color_combo, optional: true
end
