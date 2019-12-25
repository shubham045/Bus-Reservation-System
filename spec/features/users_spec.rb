require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context "create new user" do
  	scenario "should be successful" do
  		visit new_user_registration_path
  		within('form') do
  			fill_in 'user[name]', with: 'shubham'
  			fill_in 'user[email]', with: 'shubham@gmail.com'
  			fill_in 'user[password]', with: '123456'
  			fill_in 'user[password_confirmation]', with: '123456'
  		end
  		click_button 'commit'
  		sleep(3)
  		expect(page).to have_content("Welcome! You have signed up successfully.")
  	end
  end

  context "create new user" do
  	scenario "should fail" do
  		visit new_user_registration_path
  		within('form') do
  			fill_in 'user[name]', with: 'shubham'
  			fill_in 'user[password]', with: '123456'
  			fill_in 'user[password_confirmation]', with: '123456'
  		end
  		click_button 'commit'
  		expect(page).to have_content("Email can't be blank")
  	end
  end
  	
end
