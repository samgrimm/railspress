class Navbar < ApplicationRecord
  belongs_to :website
  belongs_to :nav_style
  has_many :links
  has_many :pages, through: :links
  enum position: { main: 0, footer: 1 }

  def add_link(page)
    links.build(page_id: page.id)
    save
  end
end
