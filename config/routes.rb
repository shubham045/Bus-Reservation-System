Rails.application.routes.draw do

  devise_for :users, controllers: {
      registrations: 'users/registrations'
    }

  root to: "buses#index"


#Admin Routes
  namespace :admin do
    resources :reservations, only: [:index]
    resources :buses, only: [:index] do
      resources :reservations, only: [:index]
    end
    resources :owners, only: [:index, :destroy] do
      member do
          get "update_owner"
      end
      resources :reservations, only: [:index]
      resources :buses, only: [:index] do
        resources :reservations, only: [:index]
      end
    end
  end


#Owner Routes
  namespace :owner do
    resources :buses do
      resources :reservations, only: [:index, :destroy]
    end
    resources :reservations, only: [:index]
  end


#For check Reservation
    resources :reservations, only: [:index] do
      member do
        get "cancle_reservation"
      end
    end


#Reservation Routes for all Users
    resources :buses, only: [:index] do
      resources :reservations do
        member do
          get "new_seat"
        end
      end
    end


end
