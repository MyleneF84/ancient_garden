class User < ApplicationRecord
  enum role: [:regular, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :nav, resize_to_fill: [40, 40]
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

end
