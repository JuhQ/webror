require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can add a beer when name is given" do
    visit new_beer_path
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    fill_in('beer[name]', with:'olut')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(brewery.beers.count).to eq(1)
  end

  it "should not add beer when no name is given" do
    visit new_beer_path
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(brewery.beers.count).to eq(0)
  end
end
