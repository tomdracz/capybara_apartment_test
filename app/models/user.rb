class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :site_users, inverse_of: :user
  has_many :sites, through: :site_users
end
