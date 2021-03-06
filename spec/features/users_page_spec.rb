require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "Ratings" do
    let!(:user) { FactoryBot.create :user, { username: 'Timppa', password: 'Password1', password_confirmation: 'Password1' } }

    before :each do
      sign_in(username: "Timppa", password: "Password1")
      create_beers_with_many_ratings(user, 1, 2, 3)
    end

    it "has ratings on their page" do
      visit user_path(user)
      expect(page).to have_content 'Has made 3 ratings, average rating 2.0'
    end

    it "can remove rating from their page" do
      visit user_path(user)

      find(:xpath, "(//a[text()='delete'])[1]").click
      expect(page).to have_content 'Has made 2 ratings, average rating 2.5'
    end

    it "has favorite style of beer based on given ratings" do
      visit user_path(user)
      expect(page).to have_content 'Favorite style: Lager'
    end

    it "has favorite brewery based on given ratings" do
      visit user_path(user)
      expect(page).to have_content 'Favorite brewery: anonymous'
    end
  end
end
