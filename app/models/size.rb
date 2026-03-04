class Size < ApplicationRecord
  validates :name, uniqueness: true
  validates :sort_order, uniqueness: true

  def self.next_sort_order
    pluck(:sort_order).max + 10
  end
end
