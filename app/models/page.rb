class Page < ApplicationRecord
  belongs_to :website
  belongs_to :layout, optional: true
end
