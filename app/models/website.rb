class Website < ApplicationRecord
  belongs_to :user
  has_many :pages
  has_many :navbars
  belongs_to :color_combo, optional: true
  has_one :blog

  def footer
    self.navbars.where(position: 'footer').first
  end

  def main_nav
    self.navbars.where(position: 'main').first
  end
end
