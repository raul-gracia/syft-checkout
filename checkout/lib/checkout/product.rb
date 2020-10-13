require 'yaml'

class Product
  attr_reader :code, :name, :price

  def initialize(product)
    @code = product[:code]
    @name = product[:name]
    @price = product[:price]
  end

  def self.load(filename)
    products = YAML.load(File.read(filename))
    products.map do |product|
      Product.new(product)
    end
  end
end
