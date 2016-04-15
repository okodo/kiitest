Rails.application.routes.draw do
  devise_for :users

  root to: 'application#home'

  resources :events, except: %i(new edit) do
    resources :comments, only: [:show, :create]
  end

  resources :users, only: [:update]
end
