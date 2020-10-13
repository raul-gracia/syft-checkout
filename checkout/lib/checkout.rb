require 'checkout/version'
require 'active_support/all'

require 'checkout/rules'
require 'checkout/product_rule'
require 'checkout/total_rule'
require 'checkout/basket'
require 'checkout/product'

module Checkout
  class Checkout
    attr_reader :promotional_rules
    def initialize(promotional_rules)
      @promotional_rules = promotional_rules
      @products = Product.load('products.yml')
      @basket = Basket.new
    end

    def scan(product_code)
      product = find_product(product_code)
      if product
        @basket.add_item(product, 1)
      else
        raise "Product can't be found"
      end
    end

    def total
      puts 'before'
      puts @basket.inspect
      puts "\n\n"
      product_rules.each do |rule|
        @basket.apply_rule(rule)
      end
      puts 'apply rules'
      puts @basket.inspect
      puts "\n\n"
      subtotal = @basket.subtotal
      puts 'subtotal'
      puts @basket.inspect
      puts "\n\n"

      total = total_rule.apply(subtotal)

      total.round(2)
    end

    private

    def find_product(code)
      @products.select { |p| p.code == code }.first
    end

    def product_rules
      @promotional_rules.select { |rule| rule.class == ProductRule }
    end

    def total_rule
      @promotional_rules.select { |rule| rule.class == TotalRule }.first
    end
  end
end
