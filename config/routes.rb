# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: %i[sessions password registrations],
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  as :user do
    get 'signup', to: 'users/registrations#new'
    post 'signup', to: 'users/registrations#create'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'signout', to: 'users/sessions#destroy'
    get 'edit', to: 'devise/registrations#edit'
  end
  resources :articles do
    collection do
      post 'image'     # 画像ドラッグドロップの処理
      post 'image2'    # 画像選択の処理
    end
    member do
      post 'comment'
    end
  end
  root 'homes#index'

  # 公開マイページ
  get 'profile/:user_name', to: 'profiles#show'

  # プロフィール、アカウント設定
  get 'setting/profile', to: 'profiles#edit'
  patch 'setting/profile', to: 'profiles#update'
  get 'setting/account', to: 'users#edit'
  patch 'setting/account', to: 'users#update'

  # フォロー、解除
  post 'relations/follow', to: 'relations#create'
  post 'relations/unfollow', to: 'relations#delete'

  # いいね
  post 'likes/like', to: 'likes#create'
  post 'likes/unlike', to: 'likes#delete'

  # お気に入り
  post 'favorites/favorite', to: 'favorites#create'
  post 'favorites/unfavorite', to: 'favorites#delete'

  get  'inquiry',            to: 'inquiry#index'       # 入力画面
  post 'inquiry/confirm',    to: 'inquiry#confirm'     # 確認画面
  post 'inquiry/complete',   to: 'inquiry#complete'    # 送信完了画面
end
