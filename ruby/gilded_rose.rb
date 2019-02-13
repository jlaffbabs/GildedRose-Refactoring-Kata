class GildedRose

  def initialize(items)
    @items = items
    @specials = ["Aged Brie", "Backstage passes", "Sulfuras, Hand of Ragnaros", "Conjured"]
  end

  def update_quality()
    @items.each do |item|
      unless @specials.include?(item.name)
        normal_update(item)
      end
      if item.name == "Aged Brie"
        brie_update(item)
      elsif item.name == "Backstage passes"
        backstage_update(item)
      end
    end
  end

  def normal_update(item)
    item.quality -= 1
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality -= 1
    end
    item.quality = 0 if item.quality < 0
  end

  def brie_update(item)
    unless item.quality > 49
      item.quality += 1
    end
    item.sell_in -= 1
  end

  def backstage_update(item)
    item.quality += 1
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = 0
    elsif item.sell_in < 5
      item.quality += 2
    elsif item.sell_in < 10
      item.quality += 1
    end
    item.quality = 50 if item.quality > 50
  end
end

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
