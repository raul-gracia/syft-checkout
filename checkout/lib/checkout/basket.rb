require 'checkout/line_item'
class Basket
  attr_reader :line_items

  def initialize
    @line_items = []
  end

  def add_item(product, qty)
    if in_basket?(product)
      increase_qty(product, qty)
    else
      line_items << LineItem.new(product, qty)
    end
  end

  def apply_rule(rule)
    line_items.each do |line_item|
      rule.apply_to(line_item)
    end
  end

  def subtotal
    line_items.map(&:total).reduce(:+)
  end

  private

  def in_basket?(product)
    find_line_item(product).present?
  end

  def increase_qty(product, qty)
    find_line_item(product).qty += qty
  end

  def find_line_item(product)
    line_items.select { |item| item.product_code == product.code }.first
  end
end
