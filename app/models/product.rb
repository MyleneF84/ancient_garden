class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [250, 250]
  end

  has_many :stocks
  has_many :order_products
  has_many :orders, through: :order_products
  belongs_to :category

end
