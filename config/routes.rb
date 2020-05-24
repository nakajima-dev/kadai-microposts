Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  # 見栄えをよくするため、以下のようなresourcesで定義せずそれぞれ個別にrouteを記述する。
  # resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  # 投稿は見せるのとはまた別に用意する
  # micropostsの一覧はユーザに紐づけがされているのでtoppagesindexやusersshowで表示させる。
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
