class Stock < ApplicationRecord
  belongs_to :product

  SIZES = %w[Seeds(Pack) Seedling Plant]
end
