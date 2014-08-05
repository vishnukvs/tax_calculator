class Calculator

  attr_reader :total_sales_tax, :total_price, :items

  def initialize(items_input)
    @items = items_input
    @total_price = 0.0
    @total_sales_tax = 0.0
    @sum_goods_tax = 0.0
    @sum_imports_tax = 0.0
    @goods_tax = 0.10
    @imports_tax = 0.05
    @nearest_cent = 1 / 0.05
  end

  def capture_items(type)
    goods = @items.select { |item| item[type] == true }
    return goods
  end

  def round_tax(tax_amt)
    new_tax = ((tax_amt * @nearest_cent).ceil / @nearest_cent)
    return new_tax
  end

  def compute_tax(price, qty, tax)
    tax_amt = (price * qty) * tax
    adjusted_tax = round_tax(tax_amt)
    return adjusted_tax
  end

  def update_total(total, tax)
    total += tax
    total = total.round(2)
    return total
  end


# Import  Goods Tax

  def total_goods_tax(goods)
    goods.each do |good|
      tax_amt = compute_tax(good[:price], good[:qty], @goods_tax)
      good[:total] = update_total(good[:total], tax_amt)
      @sum_goods_tax += tax_amt
    end
  end

  def apply_goods_tax
    goods = capture_items(:good)
    total_goods_tax(goods)
    return @sum_goods_tax
  end

#  Add Import Tax

  def total_import_tax(goods)
    goods.each do |good|
      tax_amt = compute_tax(good[:price], good[:qty], @imports_tax)
      good[:total] = update_total(good[:total], tax_amt)
      @sum_imports_tax += tax_amt
    end
  end
# method to apply import tax
  def apply_import_tax
    goods = @items.select { |item| item[:import] == true }
    test = total_import_tax(goods)
    return @sum_imports_tax
  end

# Total Tax

  def sum_taxes(good, import)
    tax_amt = good.to_f + import.to_f
    return tax_amt
  end

  def sales_tax
    @total_sales_tax = sum_taxes(apply_goods_tax, apply_import_tax)
    return @total_sales_tax
  end

  def capture_base_prices
    base_prices = @items.map { |item| item[:price] }.flatten
    return base_prices
  end

  def sum_base_prices
    total_base_price = capture_base_prices.inject(:+)
    return total_base_price
  end

  def total_all
    @total_price = sum_base_prices + sales_tax
    return @total_price
  end

end