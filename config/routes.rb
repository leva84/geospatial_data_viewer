# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tickets#index'

  resources :tickets, only: %i[show]

  namespace :api do
    namespace :v1 do
      resources :tickets, only: %i[create]
    end
  end
end
