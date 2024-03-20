class Product < ApplicationRecord
  has_many :stocks
  belongs_to :category

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [250, 250]
  end
end
