class CreateProductPrice < ActiveRecord::Migration[7.0]
  def change
    create_table :product_prices do |t|
      t.string :size
      t.integer :price
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
