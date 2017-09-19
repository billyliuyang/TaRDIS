Rails.application.routes.draw do

  resources :line_staffs
  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :ftes
  resources :staffs
  resources :time_managements do
    collection do
      post :next_year
      post :last_year
    end
  end
  
  resources :studies  
  resources :tasks do
    member do
      get :assign_staff
    end
  end
  resources :users

  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'
  

  root to: "studies#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
