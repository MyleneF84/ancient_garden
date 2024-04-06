class AddStateAndCheckoutSessionIdToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :state, :string, default: "pending"
    add_column :orders, :checkout_session_id, :string
    add_reference :orders, :user, foreign_key: true
  end
end
