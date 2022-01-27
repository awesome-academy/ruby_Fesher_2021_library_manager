class Book < ApplicationRecord
  PROPERTIES = %i(name price description number_of_page quantity
                  author_id publisher_id category_id images).freeze

  acts_as_paranoid

  belongs_to :author, optional: true
  belongs_to :publisher, optional: true
  belongs_to :category, optional: true
  has_many_attached :images

  scope :top_score, ->{order rate_score: :desc}
  scope :recent_added, ->{order created_at: :desc}
  scope :find_for_cart, ->(ids){where id: ids}
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
  delegate :name, to: :category, prefix: true

  validates :name, presence: true,
            length: {maximum: Settings.length.user_name_max}
  validates :description, presence: true
  validates :number_of_page, presence: true,
            numericality: {only_integer: true,
                           greater_than: Settings.length.zero}
  validates :price, presence: true,
            numericality: {only_integer: true,
                           greater_than: Settings.length.zero}
  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to: Settings.length.zero}
  validates :images,
            content_type: {in: Settings.image_type,
                           message: I18n.t("invalid_image_type")},
                           size: {less_than: Settings.image_size.megabytes,
                                  message: I18n.t("invalid_image_size")}

  def requested_book
    update quantity: quantity - Settings.length.one
  end

  def returned_book
    update quantity: quantity + Settings.length.one
  end
end
