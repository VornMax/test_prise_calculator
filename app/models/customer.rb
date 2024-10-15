class Customer < ApplicationRecord
  has_many :price_rules
  belongs_to :price_group, optional: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, allow_blank: true, format: { with: /\A\d{10}\z/, message: "must be a 10 digit number" }
  validates :address, presence: true
end
