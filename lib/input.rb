class Input
  attr_reader :input_file, :items

  def initialize(location)
    @input_file = File.open(File.dirname(File.dirname(__FILE__)) + '/input/' + location).to_a
    @exclusions = set_exclusions(File.dirname(File.dirname(__FILE__)) + '/exclusions.txt')
    @items = []
  end

  def set_exclusions(location)
    exclusions = File.open(location).to_a
    exclusions.map! { |item| item.chomp }
    return exclusions
  end

  def parse
    @input_file.each do |item|
      item = item.strip.split(/\s/)
      detect(item)
    end
    return @items
  end

  def detect(item)
    add_item = { name: detect_name(item),
                 qty: detect_qty(item),
                 price: detect_price(item),
                 good: classify_good(item),
                 import: classify_import(item),
                 total: calculate_total(item)
               }
    @items << add_item
    return @items
  end

  def detect_qty(item)
    return item[0].to_i
  end

  def detect_name(item)
    end_point = (item.index "at") - 1
    capture = item[1..end_point].join(" ")
    return capture
  end

  def detect_price(item)
    start_point = (item.index "at") + 1
    end_point = item.size
    capture = item[start_point..end_point]
    return capture[0].to_f
  end

  def classify_good(item)
    intersection = item & @exclusions
    intersection = intersection.join(" ")
    return intersection != "" ? false : true
  end

  def classify_import(item)
    check_import = item.include? 'imported'
    return check_import == true ? true : false
  end

  def calculate_total(item)
    total = detect_qty(item) * detect_price(item)
    return total
  end
end
