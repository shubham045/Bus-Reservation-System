require 'rails_helper'

# RSpec.describe Owner::BusesController, type: :controller do	
RSpec.describe Owner::BusesController do

	describe "GET #index" do
		it "print 'Hello when we call show method'" do
			user = User.create(name: "Test", email: "test@yopmail.com")
			sign_in(user)
			get :index
		end
	end
end
