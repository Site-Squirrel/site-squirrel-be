Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create update destroy]
      resources :sessions, only: [:create]
    end
  end
end
