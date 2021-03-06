Rails.application.routes.draw do


  devise_for :users
  resources :users, only: [:show]

  get 'welcome/about'

  root 'welcome#index'

  post :incoming, to: 'incoming#create'

  resources :topics do
    resources :bookmarks do
      resources :likes, only: [:create, :destroy]
      end
    end

end
