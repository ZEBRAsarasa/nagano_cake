Rails.application.routes.draw do
  devise_for :customers
   devise_scope :customers do
    get '/customers', to: redirect("/customers/sign_up")
  end
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }


  scope module: :public do
    root to: 'homes#top'
    get "homes/about" => 'homes#about'

    resources :items , only: [:index, :show]

    resources :customers, only: [:show, :edit, :update]
    get "customers/cancel" => "customers#cancel"
    patch "customers/cancel_do" => "customers#cancel_do"

  end

  namespace :admin do

    root to: "homes#top"
    get "/" => "admin#top"

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

  end

end
