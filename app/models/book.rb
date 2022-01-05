class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true
  belongs_to :category, optional: true

  scope :top_score, ->{order rate_score: :desc}

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy
  has_many :users_comments, through: :comments, source: :user
  has_many :users_likes, through: :likes, source: :user
  has_many :users_follows, through: :follows, source: :user
  delegate :name, to: :author, prefix: true
  delegate :name, to: :publisher, prefix: true

  def requested_book
    update quantity: quantity - Settings.length.one
  end
end
