Rails.application.routes.draw do


  get 'bookmarks/show'

  get 'bookmarks/new'

  get 'bookmarks/edit'

  get 'topics/index'

  get 'topics/show'

  get 'topics/new'

  get 'topics/edit'

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'

  resources :topics

end
