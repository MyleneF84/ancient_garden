class Stock < ApplicationRecord
  belongs_to :product

  SIZES = ["Seeds (Pack)", "Seedling", "Plant"]
end
