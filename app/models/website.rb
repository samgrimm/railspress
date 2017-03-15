class Website < ApplicationRecord
  belongs_to :user
  has_many :pages
  has_many :navbars
  belongs_to :color_combo, optional: true

  def footer
    self.navbars.where(position: 'footer').first
  end
end
