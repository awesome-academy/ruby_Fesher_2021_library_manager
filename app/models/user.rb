class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  # follow
  has_many :follow_books, ->{where followable_type: Book.name},
           class_name: Follow.name, dependent: :destroy
  has_many :follow_users, ->{where followable_type: User.name},
           class_name: Follow.name, dependent: :destroy
  has_many :follow_authors, ->{where followable_type: Author.name},
           class_name: Follow.name, dependent: :destroy
  # comment
  has_many :comment_books_relationship, ->{where commentable_type: Book.name},
           class_name: Comment.name, dependent: :destroy
  has_many :comment_authors_relationship,
           ->{where commentable_type: Author.name},
           class_name: Comment.name, dependent: :destroy
  # like
  has_many :like_books_relationship, ->{where likeable_type: Book.name},
           class_name: Like.name, dependent: :destroy
  has_many :like_authors_relationship, ->{where likeable_type: Author.name},
           class_name: Like.name, dependent: :destroy
  # source follow
  has_many :following_books, through: :follow_books,
    source_type: Book.name, source: :followable
  has_many :following_authors, through: :follow_authors,
    source_type: Author.name, source: :followable
  has_many :following_users, through: :follow_users,
    source_type: User.name, source: :followable
  # source comment
  has_many :comment_books, through: :comment_books_relationship,
    source_type: Book.name, source: :commentable
  has_many :comment_authors, through: :comment_authors_relationship,
    source_type: Author.name, source: :commentable
  # source comment
  has_many :like_books, through: :like_books_relationship,
    source_type: Book.name, source: :likeable
  has_many :like_authors, through: :like_authors_relationship,
    source_type: Author.name, source: :likeable
  # followers
  has_many :passive_follows, class_name: Follow.name,
    as: :followable, dependent: :destroy
  has_many :followers, through: :passive_follows,
    source: :user

  PROPERTIES =
    %i(name email address phone password password_confirmation).freeze
  validates :name, presence: true,
    length: {maximum: Settings.length.user_name_max}
  validates :email, presence: true,
    length: {maximum: Settings.length.email_max},
    format: {with: Settings.regex.email},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.length.password_min},
    allow_nil: true, if: :password
  validates :address, presence: true,
    length: {minimum: Settings.length.password_min}
  validates :phone, presence: true,
    format: {with: Settings.regex.phone}
  has_secure_password

  def is_admin?
    is_admin
  end
end
