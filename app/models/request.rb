class Request < ApplicationRecord
  PROPERTIES = %i(book_id begin_day end_day status).freeze
  enum status: {
    fresh: 0,
    confirmed: 1,
    delivered: 2,
    rejected: 3,
    returned: 4,
    expired: 5
  }
  belongs_to :user
  belongs_to :book
  delegate :name, to: :user, prefix: true
  delegate :name, to: :book, prefix: true

  scope :recent_post, ->{order created_at: :desc}

  validate :valid_begin_day,
           :valid_end_day,
           :valid_book_quantity,
           on: :create

  private
  def valid_begin_day
    return unless begin_day.blank? || begin_day < Time.zone.today

    errors.add I18n.t("requests.errors.beginday"),
               I18n.t("requests.errors.past")
  end

  def valid_end_day
    return unless end_day.blank? || end_day <= begin_day

    errors.add I18n.t("requests.errors.endday"),
               I18n.t("requests.errors.behind")
  end

  def valid_book_quantity
    return unless book.quantity <= Settings.length.zero

    errors.add I18n.t("requests.errors.quantity"),
               I18n.t("requests.errors.less_than_zero")
  end
end
