class PriceCalculator
  @redis = Redis.new

  class << self
    def calculate_prices(offers, customer)
      offers.each_with_object([]) do |offer, result|
        product = offer.product
        price = calculate_final_price(offer, customer, product)

        result << { product_id: product.id, final_price: price }
      end
    end

    private

    def calculate_final_price(offer, customer, product)
      cache_key = generate_cache_key(offer, customer, product)

      cached_price = @redis.get(cache_key)
      return cached_price.to_f if cached_price

      price = offer.price
      price = contract_rule(price, customer)
      price = nomenclature_group_rule(price, product.nomenclature_group, customer)
      price = price_group_rule(price, customer.price_group)
      price = specific_nomenclature_rule(price, product, customer)

      @redis.set(cache_key, price, ex: 86400)

      price
    end

    def generate_cache_key(offer, customer, product)
      "price:#{offer.id}:#{customer.id}:#{product.id}"
    end

    def contract_rule(price, customer)
      contract_discount = customer.contract_discount || 0
      price - (price * contract_discount / 100)
    end

    def nomenclature_group_rule(price, nomenclature_group, customer)
      rule = PriceRule.find_by(nomenclature_group_id: nomenclature_group.id, customer_id: customer.id)
      return price unless rule

      apply_rule(price, rule)
    end

    def price_group_rule(price, price_group)
      return price unless price_group

      rule = PriceRule.find_by(price_group_id: price_group.id)
      return price unless rule

      apply_rule(price, rule)
    end

    def specific_nomenclature_rule(price, product, customer)
      rule = PriceRule.find_by(product_id: product.id, customer_id: customer.id)
      return price unless rule

      apply_rule(price, rule)
    end

    def apply_rule(price, rule)
      case rule.rule_type
      when "markup"
        price + (price * rule.markup_or_discount / 100)
      when "discount"
        price - (price * rule.markup_or_discount / 100)
      when "fixed_price"
        rule.original_price
      else
        price
      end
    end
  end
end
