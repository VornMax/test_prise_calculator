# spec/models/concerns/price_calculator_spec.rb

require 'rails_helper'

RSpec.describe PriceCalculator do
  describe '.calculate_prices' do
    before do
      PriceRule.delete_all
      Offer.delete_all
      Product.delete_all
      Customer.delete_all
      PriceGroup.delete_all
      NomenclatureGroup.delete_all

      @nomenclature_group = NomenclatureGroup.create!(name: 'Двигатели', description: 'Группа деталей для двигателей')
      @product = Product.create!(title: 'Поршень', article: 'PST001', brand: 'EnginePro', description: 'Поршень для двигателя', image: 'piston.jpg', nomenclature_group: @nomenclature_group)
      @customer = Customer.create!(name: 'ООО АвтоДеталь', email: 'auto-detail@example.com', phone_number: '1234567890', address: 'Улица 1, г. Москва', contract_discount: 0)
      @offer = Offer.create!(price: 5000, delivery_date: 5, bonuses: { cashback: 100 }, stock: 20, product: @product)

      PriceRule.create!(product: @product, customer: @customer, original_price: 5000, markup_or_discount: 10, rule_type: 'markup')
    end
    it 'calculates the final prices for offers based on customer rules' do
      results = PriceCalculator.calculate_prices([ @offer ], @customer)

      expect(results.size).to eq(1)
      expect(results.first[:product_id]).to eq(@product.id)
      expect(results.first[:final_price]).to eq(5500.0)
    end

    it 'uses cached price if available' do
      cache_key = PriceCalculator.send(:generate_cache_key, @offer, @customer, @product)
      PriceCalculator.instance_variable_get(:@redis).set(cache_key, 4000)

      results = PriceCalculator.calculate_prices([ @offer ], @customer)

      expect(results.size).to eq(1)
      expect(results.first[:product_id]).to eq(@product.id)
      expect(results.first[:final_price]).to eq(4000.0)
    end
  end
end
