class User < ApplicationRecord
  PROPERTIES =
    %i(name email address phone password password_confirmation).freeze

  attr_accessor :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

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
  has_many :cmt_authors_relationship, ->{where commentable_type: Author.name},
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
  has_many :comment_authors, through: :cmt_authors_relationship,
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

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.length.expired_hour.hours.ago
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
