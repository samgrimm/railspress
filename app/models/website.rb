class Website < ApplicationRecord
  belongs_to :user
  has_many :pages
  has_many :navbars
  belongs_to :color_combo, optional: true
  has_one :blog

  def footer
    navbars.where(position: 'footer').first
  end

  def main_nav
    navbars.where(position: 'main').first
  end
end
