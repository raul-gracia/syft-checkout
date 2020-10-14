RSpec.describe Rules do
  describe '.load' do
    it 'loads all the rules from a yaml file' do
      rules = Rules.load('rules.yml')

      expect(rules).to_not be_empty
      expect(rules.map(&:class).uniq).to match_array([ProductRule, TotalRule])
    end
  end
end
