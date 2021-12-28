class Author < ApplicationRecord
  has_many :books, dependent: :nullify
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy
  has_many :users_comments, through: :comments, source: :user
  has_many :users_likes, through: :likes, source: :user
  has_many :users_follows, through: :follows, source: :user

  scope :recent_added, ->{order created_at: :desc}

  PROPERTIES = %i(name description).freeze
  validates :name, presence: true,
    length: {maximum: Settings.length.user_name_max}
  validates :description, presence: true
end
