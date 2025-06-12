Rails.application.routes.draw do
  # session actions
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  # standard resources
  resources :students
  resources :mentors
  resources :enrollments, except: %i[new create] # new/create are nested under courses
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :coding_classes
  resources :trimesters, only: %i[index show edit update]

  # course nested resources
  resources :courses do
    resources :submissions, only: %i[new create edit update] # student submission form
    resources :enrollments, only: %i[new create] # admin enrolling student into course
  end

  # for mentors to edit/update any submission
  resources :submissions, only: %i[edit update]

  # health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # optional: PWA setup
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # static routes
  root 'home#index'
  get '/dashboard', to: 'admin_dashboard#index'

  # auth routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # API routes
  namespace :api do
    namespace :v1 do
      get '/courses', to: 'courses#index'
      get '/courses/:course_id/enrollments', to: 'enrollments#index'
    end
  end
end
