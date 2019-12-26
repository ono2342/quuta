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
  end
  root 'homes#index'

  get 'profile/:user_name', to: 'profiles#show'
  get 'setting/profile', to: 'profiles#edit'
  patch 'setting/profile', to: 'profiles#update'
end
