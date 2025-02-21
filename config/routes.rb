# rubocop:disable Style/FrozenStringLiteralComment
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :articles, except: [ :new, :edit ]

  resources :books

  resources :categories, only: [ :index, :update ]

  # index
  get "landing", to: "index#landing"
  get "email_new", to: "index#email_new"
  post "email_new", to: "index#email_create"
  get "chatgpt_connection", to: "index#chatgpt_connection"

  namespace :mailgun, constraints: { format: "json" } do
    post "forward_email", to: "forward_email"
  end

  resources :transactions do
    patch "api_update", on: :member
  end
  get "dashboard", to: "transactions#dashboard"

  # Defines the root path route ("/")
  devise_scope :user do
    root "users/sessions#new"
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :user_emails, only: [ :new, :create, :destroy ]
end
# rubocop:enable Style/FrozenStringLiteralComment
