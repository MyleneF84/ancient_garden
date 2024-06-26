class Category < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
    attachable.variant :medium, resize_to_fill: [250, 250]
    attachable.variant :large, resize_to_fill: [300, 300]
  end

  has_many :products

  validates :name, :description, presence: true
end
