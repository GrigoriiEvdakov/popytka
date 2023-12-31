# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create edit update]
  resources :questions do
    resources :answers, except: %i[new show]
  end
  # delete '/questions/:question_id/answers/:id', to: 'answers#destroy'
  # get '/questions', to: 'questions#index'
  # get '/questions/new', to: 'questions#new'
  # get '/questions/:id/edit', to: 'questions#edit'
  root 'pages#index'
  # post '/questions', to: 'questions#create'
  # post '/questions/:question_id/answers', to: 'answers#create'
  namespace :admin do
    resources :users, only: %i[index create]
  end   
end
