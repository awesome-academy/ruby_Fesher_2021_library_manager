class Comment < ApplicationRecord
  PROPERTIES = %i(commentable_type commentable_id content rate_score).freeze

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  scope :recent_post, ->{order created_at: :desc}

  validates :content, presence: true
end
