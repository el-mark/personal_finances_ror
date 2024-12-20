# rubocop:disable Style/FrozenStringLiteralComment
Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :transactions do
    patch "api_update", on: :member
  end
  resources :articles, except: [ :new, :edit ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "index#landing"
  # root "devise/sessions#new"
  get "landing", to: "index#landing"
  get "home", to: "index#home"
  get "email_new", to: "index#email_new"
  post "email_new", to: "index#email_create"
  get "chatgpt_connection", to: "index#chatgpt_connection"

  namespace :mailgun, constraints: { format: "json" } do
    post "forward_email", to: "forward_email"
  end
end

# rubocop:enable Style/FrozenStringLiteralComment
