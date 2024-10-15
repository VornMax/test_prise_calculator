class NomenclatureGroup < ApplicationRecord
  has_many :products

  validates :name, presence: true
end
