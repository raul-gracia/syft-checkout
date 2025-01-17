class LineItem
  attr_accessor :discounted_price, :qty

  def initialize(product, qty = 0)
    @product = product
    @qty = qty
    @discounted_price = nil
  end

  def total
    discounted_price ? qty * discounted_price : qty * @product.price
  end

  def product_code
    @product.code
  end
end
