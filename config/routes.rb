Rails.application.routes.draw do
  resources :posts
  get "/contact", to: "contacts#new"
  post "/contact", to: "contacts#create"
  root "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
