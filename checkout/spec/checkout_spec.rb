RSpec.describe Checkout::Checkout do
  describe '.new' do
    it 'initializes a new checkout with given promotional rules' do
      rules = double(:rules)
      expect(Product).to receive(:load).with('products.yml')

      co = Checkout::Checkout.new(rules)

      expect(co.promotional_rules).to eq rules
    end
  end

  describe '#scan' do
    context 'with a valid product code' do
      it 'delegates calls to the basket' do
        rules = double(:rules)
        co = Checkout::Checkout.new(rules)

        expect_any_instance_of(Basket).to receive(:add_item)

        co.scan('002')
      end
    end
    context 'with an invalid product code' do
      it 'raises and exception' do
        rules = double(:rules)
        co = Checkout::Checkout.new(rules)

        expect { co.scan('abc') }.to raise_error("Product can't be found")
      end
    end
  end

  describe '#total' do
    it 'calls apply rule with every rule to the basket' do
      rule1 = double(:rule1)
      rule2 = double(:rule2)
      rule3 = double(:rule3, apply_to: 2)

      rules = [rule1, rule2, rule3]
      co = Checkout::Checkout.new(rules)
      co.scan('001')
      allow(co).to receive(:total_rule).and_return(rule3)
      allow(co).to receive(:product_rules).and_return([rule1, rule2])

      expect(rule1).to receive(:apply_to).once
      expect(rule2).to receive(:apply_to).once

      co.total
    end

    it 'calls aplly_to on the total rule' do
      total_rule = double(:rule3, apply_to: 2)
      co = Checkout::Checkout.new([])
      allow(co).to receive(:total_rule).and_return(total_rule)
      expect(total_rule).to receive(:apply_to).once

      co.total
    end
  end
end
