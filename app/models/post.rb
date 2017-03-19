class Post < ApplicationRecord
  belongs_to :blog
  enum status: { draft: 0, published: 1 }

  def toggle_status
    if draft?
      published!
    else
      draft!
    end
  end
end
