class Product < ApplicationRecord
  belongs_to :nomenclature_group
  has_many :offers
  has_many :price_rules

  validates :title, :article, :brand, presence: true
end
