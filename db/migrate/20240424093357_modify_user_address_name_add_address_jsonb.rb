class ModifyUserAddressNameAddAddressJsonb < ActiveRecord::Migration[7.0]
  def change
    rename_column(:users, :address, :old_address)
    add_column(:users, :address, :jsonb)
  end
end
