Rails.application.routes.draw do
  root 'home#index'


  resources :home, only: [:index]

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :competitions
    resources :proofs
    resources :categories
    resources :swimmers
    resources :teams
    resources :proof_category_swimmers do
      collection do
        get :swimmers_by_category
        get :categories_by_proof
      end
    end
    resources :swimming_marker_groups do
      collection do
        get :categories_by_proof
      end

      resources :swimming_marker_blocks
    end

    resources :swimming_marker_block_lists do
      member do
        patch :update_time
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
