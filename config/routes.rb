Rails.application.routes.draw do
  root 'events#index'
  devise_for :users

  resources :events
  resources :users, only: [:index, :create, :update]

  # routes for creating and removing attendees
  post '/events/:id/attend', to: 'events#attend', as: 'attend_event'
  delete 'events/:id/unattend', to: 'events#unattend', as: 'unattend_event'
end
