class ProductRule
  attr_reader :product_code, :min_qty, :new_price
  def initialize(rule)
    @product_code = rule[:product_code]
    @min_qty = rule[:min_qty]
    @new_price = rule[:new_price]
  end

  def apply(line_item)
    return unless applies?(line_item)

    line_item.discounted_price = new_price
  end

  private

  def applies?(line_item)
    line_item.product.code == product_code &&
      line_item.qty >= min_qty
  end
end
