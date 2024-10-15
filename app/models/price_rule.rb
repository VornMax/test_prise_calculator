class PriceRule < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :nomenclature_group, optional: true
  belongs_to :price_group, optional: true
  belongs_to :customer, optional: true

  validates :markup_or_discount, :rule_type, presence: true
end
