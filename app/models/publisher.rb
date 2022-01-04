class Publisher < ApplicationRecord
  PROPERTIES = %i(name description).freeze

  has_many :books, dependent: :nullify
  scope :recent_added, ->{order created_at: :desc}

  validates :name, presence: true,
    length: {maximum: Settings.length.user_name_max}
  validates :description, presence: true
end
