# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :articles, path: 'api/v1/article'
  # mount_devise_token_auth_for "User", at: "auth"
  # resources :user


  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :articles
    end
  end

  as :user do
    # Define routes for User within this block.
  end
  as :user do
    # Define routes for User within this block.
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/api/v1/', to: 'article#'
end
