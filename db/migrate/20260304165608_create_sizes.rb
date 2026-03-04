class CreateSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :sizes do |t|
      t.string :name, null: false
      t.integer :sort_order, null: false, default: 10

      t.timestamps
    end

    add_index :sizes, :sort_order
  end
end
