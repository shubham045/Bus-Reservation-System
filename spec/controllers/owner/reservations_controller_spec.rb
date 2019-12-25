require 'rails_helper'

RSpec.describe Owner::ReservationsController, type: :controller do
  describe "GET #index" do
    it "going in index method" do
      # user = User.create(name: "Test", email: "test@yopmail.com")
	  # sign_in(user)
	  get :index
	  binding.pry
    end
  end
end
