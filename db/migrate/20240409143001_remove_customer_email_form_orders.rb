class RemoveCustomerEmailFormOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :customer_email
  end
end
