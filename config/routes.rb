# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,skip: %i[sessions password registrations],
                    controllers: { registrations: 'users/registrations'}
  as :user do
    get 'signup', to: 'users/registrations#new'
    post 'signup', to: 'users/registrations#create'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'signout', to: 'users/sessions#destroy'
    get 'edit', to: 'devise/registrations#edit'
  end
  resources :articles
end
