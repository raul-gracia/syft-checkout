RSpec.describe LineItem do
  describe '.new' do
    it 'initializes a new Line Item' do
      product = Product.new({ code: '001', name: 'test', price: 10 })
      line_item = LineItem.new(product, 2)

      expect(line_item.discounted_price).to eq nil
      expect(line_item.qty).to eq 2
    end
  end
  describe '#total' do
    context 'with discounted price' do
      it 'returns the discounted price times the qty' do
        product = Product.new({ code: '001', name: 'test', price: 10 })
        line_item = LineItem.new(product, 2)
        line_item.discounted_price = 3

        expect(line_item.total).to eq 6
      end
    end
    context 'without discounted price' do
      it 'returns the product price times the qty' do
        product = Product.new({ code: '001', name: 'test', price: 10 })
        line_item = LineItem.new(product, 2)

        expect(line_item.total).to eq 20
      end
    end
  end
end
