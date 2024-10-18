class User < ApplicationRecord
  enum role: [:regular, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  store :address,
        accessors: [ :street_number, :street_name, :opt, :postal_code, :city, :country ],
        coder: JSON

  has_many :orders
  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :nav, resize_to_fill: [40, 40]
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  def display_avatar(variant)
    avatar.attached? ? avatar.variant(variant) : default_avatar_image(variant)
  end

  private

  def default_avatar_image(variant)
    size = case variant
    when :nav
      40
    when :thumb
      100
    else
     100
    end
    "https://via.placeholder.com/#{size}"
  end
end
