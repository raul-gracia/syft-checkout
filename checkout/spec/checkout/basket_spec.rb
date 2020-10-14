RSpec.describe Basket do
  describe '#add_item' do
    context 'when item is not on the basket' do
      it 'adds a new line item' do
        product = Product.new({ code: '001', name: 'test', price: 10 })

        subject.add_item(product, 1)

        items = subject.line_items

        expect(items.size).to eq 1
      end
    end
    context 'when item is already on the basket' do
      it 'increases the qty on the line item' do
        product = Product.new({ code: '001', name: 'test', price: 10 })

        subject.add_item(product, 1)
        subject.add_item(product, 3)

        items = subject.line_items

        expect(items.size).to eq 1
        line_item = items.first

        expect(line_item.qty).to eq 4
      end
    end
  end

  describe '#apply_rule' do
    it 'calls apply_to method with each line_item' do
      product_1 = Product.new({ code: '001', name: 'test', price: 10 })
      product_2 = Product.new({ code: '002', name: 'test', price: 20 })

      subject.add_item(product_1, 4)
      subject.add_item(product_2, 3)

      rule = double(:rule)
      expect(rule).to receive(:apply_to).twice

      subject.apply_rule(rule)
    end
  end

  describe '#subtotal' do
    it 'sums up all the line items totals' do
      product_1 = Product.new({ code: '001', name: 'test', price: 10 })
      product_2 = Product.new({ code: '002', name: 'test', price: 20 })

      subject.add_item(product_1, 4)
      subject.add_item(product_2, 3)

      expect(subject.subtotal).to eq 100
    end
  end
end
