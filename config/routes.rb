Rails.application.routes.draw do
  devise_for :users
  resources :message do
    resources :comments
  end
  root 'message#index'
end
