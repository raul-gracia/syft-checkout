class TotalRule
  attr_reader :min_total, :discount

  def initialize(rule)
    @min_total = rule[:min_total]
    @discount = rule[:discount]
  end

  def apply_to(subtotal)
    return subtotal unless applies_to?(subtotal)

    (subtotal * (1 - discount)).to_f
  end

  private

  def applies_to?(subtotal)
    subtotal >= min_total
  end
end
