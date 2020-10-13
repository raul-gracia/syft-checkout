require 'checkout/line_item'
class Basket
  def initialize
    @line_items = []
  end

  def add_item(product, qty)
    if in_basket?(product)
      add_qty(product, qty)
    else
      @line_items << LineItem.new(product, qty)
    end
  end

  def apply_rule(rule)
    @line_items.each do |line_item|
      rule.apply(line_item)
    end
  end

  def subtotal
    @line_items.map(&:total).reduce(:+)
  end

  private

  def in_basket?(product)
    find_line_item(product).present?
  end

  def add_qty(product, qty)
    find_line_item(product).qty += qty
  end

  def find_line_item(product)
    @line_items.select { |item| item.product.code == product.code }.first
  end
end
