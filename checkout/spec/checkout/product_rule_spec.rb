RSpec.describe ProductRule do
  describe '.new' do
    it 'initializes a new rule from a given hash' do
      hash = { product_code: '001', min_qty: 20, new_price: 12 }
      p = ProductRule.new(hash)

      expect(p.product_code).to eq '001'
      expect(p.min_qty).to eq 20
      expect(p.new_price).to eq 12
    end
  end
  describe '#apply_to' do
    it 'applies the rule to the line item when applicable' do
      product = Product.new({ code: '001', name: 'test', price: 10 })
      rule = ProductRule.new({ product_code: '001', min_qty: 20, new_price: 6 })
      line_item = LineItem.new(product, 22)

      rule.apply_to(line_item)

      expect(line_item.discounted_price).to eq 6
    end
    it 'does NOT apply the rule to the line item when NOT applicable' do
      product = Product.new({ code: '001', name: 'test', price: 10 })
      rule = ProductRule.new({ product_code: '001', min_qty: 20, new_price: 6 })
      line_item = LineItem.new(product, 8)

      rule.apply_to(line_item)

      expect(line_item.discounted_price).to eq nil
    end
  end
end
