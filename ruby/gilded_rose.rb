class GildedRose
    SELL_IN_STANDARD_1    = 11
    SELL_IN_STANDARD_2    =  6
    ITEM_QUALITY_STANDARD = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      # step 1 : decide none of them
        item.quality = deduct_quality_when_none_of_them(item.name, item.quality)
      # step 2 : decide ono of Aged Brie or Backstage passes"
        if item.name == "Aged Brie" || item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = item.quality + 1 if item.quality < ITEM_QUALITY_STANDARD
          if item.name == "Backstage passes to a TAFKAL80ETC concert" && item.quality < ITEM_QUALITY_STANDARD
            item.quality = quality_increasement(item.sell_in, item.quality)
          end
        end

      # step 3: final adjustment
      item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
      item.quality = deduct_quality_when_case_1_true(item.name, item.quality) if item.sell_in < 0

    end # each end
  end # method end

  def deduct_quality_when_none_of_them(input_name, input_quality)
    if input_name != "Sulfuras, Hand of Ragnaros" and input_name != "Aged Brie" and input_name != "Backstage passes to a TAFKAL80ETC concert"
      input_quality -= 1 if input_quality > 0
      input_quality
    else
      input_quality
    end
  end

  def deduct_quality_when_case_1_true(input_name, input_quality)
    if input_name == "Aged Brie" && input_quality < ITEM_QUALITY_STANDARD
      input_quality + 1
    elsif input_name == "Backstage passes to a TAFKAL80ETC concert"
      0
    else
      input_quality = deduct_quality_when_none_of_them(input_name, input_quality)
    end
  end

  def quality_increasement(input_sell_in, input_quality)
    [SELL_IN_STANDARD_1, SELL_IN_STANDARD_2].each do |standard|
      if input_sell_in < standard
        input_quality += 1
      else
        input_quality
      end
    end
    input_quality
  end

end # class end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
