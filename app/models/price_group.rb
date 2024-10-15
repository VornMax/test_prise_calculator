class PriceGroup < ApplicationRecord
  has_many :price_rules
  has_many :customers
  belongs_to :price_group, optional: true

  validates :name, presence: true
end
