class Page < ApplicationRecord
  validates :slug, presence: true, uniqueness: true
end
