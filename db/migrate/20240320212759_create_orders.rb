class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.string :address
      t.integer :total
      t.boolean :fulfilled

      t.timestamps
    end
  end
end
