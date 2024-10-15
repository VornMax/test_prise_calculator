Product.delete_all
Offer.delete_all
PriceRule.delete_all
NomenclatureGroup.delete_all
PriceGroup.delete_all
Customer.delete_all

nomenclature_groups = [
  { name: 'Двигатели', description: 'Группа деталей для двигателей' },
  { name: 'Трансмиссия', description: 'Группа деталей для трансмиссий' },
  { name: 'Ходовая часть', description: 'Группа деталей для ходовой части' }
]

nomenclature_groups.each do |group|
  NomenclatureGroup.create!(group)
end

products = [
  { title: 'Поршень', article: 'PST001', brand: 'EnginePro', description: 'Поршень для двигателя', image: 'piston.jpg', nomenclature_group: NomenclatureGroup.find_by(name: 'Двигатели') },
  { title: 'Сцепление', article: 'CLT002', brand: 'ClutchMaster', description: 'Комплект сцепления', image: 'clutch.jpg', nomenclature_group: NomenclatureGroup.find_by(name: 'Трансмиссия') },
  { title: 'Амортизатор', article: 'SHK003', brand: 'ShockMaster', description: 'Амортизатор передний', image: 'shock.jpg', nomenclature_group: NomenclatureGroup.find_by(name: 'Ходовая часть') }
]

products.each do |product|
  Product.create!(product)
end

customers = [
  { name: 'ООО АвтоДеталь', email: 'auto-detail@example.com', phone_number: '1234567890', address: 'Улица 1, г. Москва', contract_discount: 10, price_group: PriceGroup.find_by(name: 'Оптовая') },
  { name: 'ООО Моторсервис', email: 'motor-service@example.com', phone_number: '0987654321', address: 'Улица 2, г. Санкт-Петербург', contract_discount: 5, price_group: PriceGroup.find_by(name: 'Розничная') }
]

customers.each do |customer|
  Customer.create!(customer)
end

price_groups = [
  { name: 'Оптовая', description: 'Ценовая группа для оптовых покупателей' },
  { name: 'Розничная', description: 'Ценовая группа для розничных покупателей' }
]

price_groups.each do |price_group|
  PriceGroup.create!(price_group)
end

offers = [
  { price: 5000, delivery_date: 5, bonuses: { cashback: 100 }, stock: 20, product: Product.find_by(title: 'Поршень') },
  { price: 8000, delivery_date: 7, bonuses: { cashback: 150 }, stock: 15, product: Product.find_by(title: 'Сцепление') },
  { price: 3000, delivery_date: 3, bonuses: { cashback: 50 }, stock: 30, product: Product.find_by(title: 'Амортизатор') }
]

offers.each do |offer|
  Offer.create!(offer)
end

price_rules = [
  { product: Product.find_by(title: 'Поршень'), customer: Customer.find_by(name: 'ООО АвтоДеталь'), original_price: 5000, markup_or_discount: -10, rule_type: 'discount' },
  { product: Product.find_by(title: 'Сцепление'), customer: Customer.find_by(name: 'ООО Моторсервис'), original_price: 8000, markup_or_discount: 5, rule_type: 'markup' },
  { nomenclature_group: NomenclatureGroup.find_by(name: 'Ходовая часть'), customer: Customer.find_by(name: 'ООО АвтоДеталь'), original_price: 3000, markup_or_discount: -15, rule_type: 'discount' }
]

price_rules.each do |rule|
  PriceRule.create!(rule)
end
