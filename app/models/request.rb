class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book
  scope :recent_post, ->{order created_at: :desc}
end
