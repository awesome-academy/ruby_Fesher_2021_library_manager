class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true
  belongs_to :category, optional: true

  scope :top_score, ->{order rate_score: :desc}
  scope :sort_by_likes_count_asc, (lambda do
    left_joins(:likes).group(:id).order("COUNT(likes.id) ASC")
  end)
  scope :sort_by_likes_count_desc, (lambda do
    left_joins(:likes).group(:id).order("COUNT(likes.id) DESC")
  end)
  scope :sort_by_comments_count_asc, (lambda do
    left_joins(:comments).group(:id).order("COUNT(comments.id) ASC")
  end)
  scope :sort_by_comments_count_desc, (lambda do
    left_joins(:comments).group(:id).order("COUNT(comments.id) DESC")
  end)

  ransacker :created_at do
    Arel.sql("date(created_at)")
  end

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

  def returned_book
    update quantity: quantity + Settings.length.one
  end
end
