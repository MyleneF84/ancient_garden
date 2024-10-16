class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :user
  paginates_per 10

  scope :paid, -> { where(state: "paid") }
  scope :pending, -> { where(state: "pending") }
  scope :this_week, -> { where(created_at: 1.week.ago.end_of_week..Date.today)}
  scope :this_month, -> { where(created_at: 1.month.ago.beginning_of_month..Date.today)}
  scope :last_three_months, -> { where(created_at: 3.months.ago.beginning_of_month..Date.today)}
  scope :last_year, -> { where(created_at: 1.year.ago.beginning_of_year..Date.today)}

  def paid?
    state == "paid"
  end

  def pending?
    state == "pending"
  end

  def this_week
    where(created_at: 1.week.ago.beginning_of_week..Date.today)
  end

end
