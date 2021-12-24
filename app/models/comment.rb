class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  scope :recent_post, ->{order created_at: :desc}
end
