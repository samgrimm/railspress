class Navbar < ApplicationRecord
  belongs_to :website
  has_many :links
  has_many :pages, through: :links
end
