Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post '/send_friend_request', to: 'users#send_friend_request'
  get '/friend_requests', to: 'users#friend_requests'
  get '/friend_responses', to: 'users#friend_responses'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
