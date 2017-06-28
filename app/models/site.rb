class Site < ApplicationRecord
  validates :name, :domain, presence: true, uniqueness: true
  has_many :site_users, inverse_of: :site
  has_many :users, through: :site_users

  accepts_nested_attributes_for :site_users, allow_destroy: true

  after_create :set_up_tenant

  def parameterized_name
    name.parameterize(separator: "_")
  end

  private

  def set_up_tenant
    return unless valid?
    Apartment::Tenant.create(parameterized_name)
  end
end
