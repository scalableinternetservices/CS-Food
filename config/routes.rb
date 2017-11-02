Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  resources :orders do
    collection do
      get 'myorders'
    end
    member do
      put 'pick'
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
