Rails.application.routes.draw do


  resources :items, except: [:destroy, :edit, :update]
  devise_for :users
  get 'home/index'

  resources :users, controllers: {registrations: "registrations"}

  resources :orders do
    collection do
      get 'myorders'
    end
    member do
      put 'pick'
    end
    member do
      put 'receive'
    end
    collection do
      get 'mypicks'
    end
    collection do
      get 'myhistory'
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
