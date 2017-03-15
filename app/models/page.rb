class Page < ApplicationRecord
  belongs_to :website
  belongs_to :layout, optional: true
  has_many :links
  has_many :navbars, through: :links
end
