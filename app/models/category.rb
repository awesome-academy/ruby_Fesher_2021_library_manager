class Category < ApplicationRecord
  PROPERTIES = %i(name).freeze

  has_many :books, dependent: :nullify

  scope :recent_added, ->{order created_at: :desc}

  validates :name, presence: true,
    length: {maximum: Settings.length.user_name_max}
end
