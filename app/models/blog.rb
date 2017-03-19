class Blog < ApplicationRecord
  belongs_to :website
  has_many :posts
end
