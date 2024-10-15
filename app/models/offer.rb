class Offer < ApplicationRecord
  belongs_to :product

  validates :price, :delivery_date, :stock, presence: true
end
