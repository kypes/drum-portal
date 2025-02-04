Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Authentication routes
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # API routes
  namespace :api do
    post "markdown/preview", to: "markdown#preview"
  end

  # Root path based on user role
  authenticated :user, ->(user) { user.teacher? } do
    root "teacher/dashboard#index", as: :teacher_root
  end

  authenticated :user, ->(user) { user.student? } do
    root "student/dashboard#index", as: :student_root
  end

  root "home#index"

  # Teacher namespace
  namespace :teacher do
    get "dashboard", to: "dashboard#index"
    resources :lessons do
      resources :comments, only: [ :create, :destroy ]
    end
    resources :students, only: [ :index, :show ]
  end

  # Student namespace
  namespace :student do
    get "dashboard", to: "dashboard#index"
    resources :lessons, only: [ :index, :show ] do
      member do
        post :mark_as_viewed
      end
      resources :comments, only: [ :create, :destroy ]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
