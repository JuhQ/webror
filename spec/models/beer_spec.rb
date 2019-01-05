require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has the name set correctly" do
    beer = Beer.new name:"Olut"

    expect(beer.name).to eq("Olut")
  end

  it "has the style set correctly" do
    beer = Beer.new style:"Lager"

    expect(beer.style).to eq("Lager")
  end

  it "has the brewery id set correctly" do
    beer = Beer.new brewery_id: 1

    expect(beer.brewery_id).to eq(1)
  end

  describe "with proper data" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "with improper data" do
    it "is not saved if no name" do
      beer = Beer.new style:"Lager"
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved if no style" do
      beer = Beer.new name:"Olut"
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

end
