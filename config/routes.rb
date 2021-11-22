Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  root to: 'homes#top'
  get "homes/about" => 'homes#about'

end
