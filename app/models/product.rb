class Product < ApplicationRecord
  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
    attachable.variant :medium, resize_to_fill: [250, 250]
  end

  has_many :stocks
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :product_prices
  accepts_nested_attributes_for :product_prices
  belongs_to :category

  SIZES = ["Seeds (Pack)", "Seedling", "Plant"]

  def prices
    product_prices.pluck(:price)
  end
end
