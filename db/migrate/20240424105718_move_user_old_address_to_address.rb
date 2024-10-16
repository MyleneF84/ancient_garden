class MoveUserOldAddressToAddress < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      if user.old_address
        m = user.old_address.match(/^(\d+)\s(.+)\s(\d{5})\s(.+)\s(\w{2})$/)
        user.update(street_number: m[1], street_name: m[2], postal_code: m[3], city: m[4], country: m[5])
      end
    end

    remove_column(:users, :old_address)
  end
end
