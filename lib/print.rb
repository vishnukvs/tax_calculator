class Print

  def initialize(items, total_sales_tax, total_price)
    @items = items
    @sales_tax = total_sales_tax
    @price = total_price
  end

  def scrub_decimals(item)
    item = "%.2f" % item
    return item
  end

  def display_item(item)
      item[:total] = scrub_decimals(item[:total])
      puts "#{item[:qty]} #{item[:name]}: #{item[:total]}"
  end

  def display_sales_tax
    @sales_tax = scrub_decimals(@sales_tax)
    puts "Sales Taxes: #{@sales_tax}"
  end

  def display_price
    @price = scrub_decimals(@price)
    puts "Total: #{@price}"
  end

  def show
    puts "Output: "
    @items.each do |item|
      display_item(item)
    end
    display_sales_tax
    display_price
  end

  def self.review(input, filename)
    puts "Input from #{filename}:"
    puts input
    puts "\n"
  end
end