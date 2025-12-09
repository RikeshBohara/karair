Rails.application.routes.draw do
  root "home#index"

  resources :jobs do
    resources :job_applications, only: [ :index, :show, :new, :create ]
    post "send_interview_email", on: :member
  end

  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  devise_for :users,
              controllers: {
                sessions: "users/sessions",
                registrations: "users/registrations"
              }

  resources :profiles, only: [ :show, :edit, :update ]
  resources :notifications, only: [ :index ] do
    post "mark_as_read", on: :member
  end


  get "home/index"
  get "status" => "application#status"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
