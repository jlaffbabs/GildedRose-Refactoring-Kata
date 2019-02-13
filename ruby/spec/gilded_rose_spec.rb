require 'spec_helper'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "quality degrades twice as fast after sell-by date" do
      items = [Item.new("foo", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end  

    it "quality degrades by 1 before sell-by date" do
      items = [Item.new("foo", 1, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 19
    end

    it "sell-in reduces by 1 each day" do
      items = [Item.new("foo", 3, 18)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 2
    end

    it "quality of an item is never negative" do
      items = [Item.new("foo", 8, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "Aged Brie becomes more valuable with time" do
      items = [Item.new("Aged Brie", 6, 39)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 40
    end

    it "Quality can never be greater than 50" do
      items = [Item.new("Aged Brie", 1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "Sulfuras never changes sell-in or quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 8, 8)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
      expect(items[0].sell_in).to eq 8
    end

    it "Backstage Passes increases in quality as sell-in increases" do
      items = [Item.new("Backstage passes", 20, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 6
    end

    it "Backstage passes increases quality by 2 within 10 days" do
      items = [Item.new("Backstage passes", 6, 7)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end
    
    it "Backstage passes increases quality by 3 within 5 days" do
      items = [Item.new("Backstage passes", 5, 7)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 10
    end

    it "Backstage passes are worth 0 after concert" do
      items = [Item.new("Backstage passes", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "Conjured items degrade in quality twice as fast as normal" do
      items = [Item.new("Conjured", 8, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "Conjured items degrade by 4 after sell-by" do
      items = [Item.new("Conjured", 0, 9)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
    end
  end

end
