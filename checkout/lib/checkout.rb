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
      raise "Product can't be found" unless product

      @basket.add_item(product, 1)
    end

    def total
      product_rules.each do |rule|
        @basket.apply_rule(rule)
      end
      subtotal = @basket.subtotal
      total = total_rule.apply_to(subtotal)

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
