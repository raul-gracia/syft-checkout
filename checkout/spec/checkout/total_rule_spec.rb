RSpec.describe TotalRule do
  describe '.new' do
    it 'initializes a new rule from a given hash' do
      hash = { min_total: 30, discount: 0.2 }
      rule = TotalRule.new(hash)

      expect(rule.min_total).to eq 30
      expect(rule.discount).to eq 0.2
    end
  end
  describe '#apply_to' do
    it 'applies the rule to the subtotal when applicable' do
      rule = TotalRule.new({ min_total: 30, discount: 0.2 })

      total = rule.apply_to(31)

      expect(total).to eq 24.8
    end
    it 'does NOT apply the rule to the subtotal when NOT applicable' do
      rule = TotalRule.new({ min_total: 30, discount: 0.2 })

      total = rule.apply_to(25)

      expect(total).to eq 25
    end
  end
end
