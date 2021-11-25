Rails.application.routes.draw do
  devise_for :customers,path:"", cotrollers: {
  }
  # devise_scope :customers do
  #   get '/customers', to: redirect("/customers/sign_up")
  # end
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }


  scope module: :public do
    root to: 'homes#top'
    get "homes/about" => 'homes#about'

    resources :items , only: [:index, :show]

    resource :customers, only: [:show, :edit, :update] do
      collection do
        get :cancel
        patch :cancel_do
      end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end

  namespace :admin do

    root to: "homes#top"
    get "/" => "admin#top"

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

  end

end
