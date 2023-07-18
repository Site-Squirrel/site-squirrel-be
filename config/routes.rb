Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create update destroy] do
        resources :trips, only: %i[index create destroy], controller: "users/trips"
      end
      resources :sessions, only: [:create]
    end
  end
end
