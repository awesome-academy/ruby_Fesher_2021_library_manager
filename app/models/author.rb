class Author < ApplicationRecord
  has_many :books, dependent: :nullify
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :follows, as: :followable, dependent: :destroy
  has_many :users_comments, through: :comments, source: :user
  has_many :users_likes, through: :likes, source: :user
  has_many :users_follows, through: :follows, source: :user
end
