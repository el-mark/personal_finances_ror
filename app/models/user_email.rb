class UserEmail < ApplicationRecord
  belongs_to :user
  validates :address, uniqueness: true
end
