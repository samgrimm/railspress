class Website < ApplicationRecord
  belongs_to :user
  has_many :pages
  has_many :navbars
  belongs_to :color_combo, optional: true
end
