RSpec.describe Product do
  describe '.new' do
    it 'initializes with data from hash' do
      hash = { code: '000', name: 'test', price: 1 }
      p = Product.new(hash)
      expect(p.code).to eq '000'
      expect(p.name).to eq 'test'
      expect(p.price).to eq 1
    end
  end
  describe '.load' do
    it 'loads all the products from a yaml file' do
      products = Product.load('products.yml')

      expect(products.all? { |p| p.class == Product }).to be_truthy
      p = products.first
      expect(p.code).to eq '001'
      expect(p.name).to eq 'Lavender Heart'
      expect(p.price).to eq 9.25
    end
  end
end
