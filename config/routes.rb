Rails.application.routes.draw do
  #scope "(:locale)", locale: /(en|sp)/, defaults: {locale: "sp"}  do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    
  acts_as_archived

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', confirmations: 'users/confirmations', invitations: 'users/invitations' }
  match '/impersonate', to: 'users/impersonations#destroy', via: [:delete], as: :impersonate

  if Rails.env.production?
    require 'sidekiq/web'

    authenticate :user, lambda { |user| user.is?(:admin) } do
      mount Sidekiq::Web => '/admin/sidekick'
    end
  end

  match 'test/exception', to: 'test#exception', via: :get
  match 'test/email', to: 'test#email', via: :get

  # Front end
  match '/settings', to: 'users/settings#edit', via: [:get], as: :user_settings
  match '/settings', to: 'users/settings#update', via: [:patch, :put]

  resources :communities, except: [:new, :create] do
    get :list, on: :collection
  end

  resources :mates, only: [:new, :create, :destroy] do
    post :reinvite, on: :member
    post :promote, on: :member
    post :demote, on: :member
  end

  resources :service_providers

  namespace :admin do
    resources :communities, except: [:show], concerns: :acts_as_archived

    resources :mates, only: [:new, :create, :destroy] do
      post :reinvite, on: :member
      post :promote, on: :member
      post :demote, on: :member
    end

    resources :users, except: [:show], concerns: :acts_as_archived do
      post :reinvite, on: :member
      post :impersonate, on: :member
    end

    root to: 'users#index'
  end
  end #end locale

  # if you want EffectivePages to render the home / root page
  # uncomment the following line and create an Effective::Page with slug == 'home'
  # root :to => 'Effective::Pages#show', :id => 'home'
  root to: 'static_pages#home'
  match '/es', to: 'static_pages#home', locale: 'es', via: [:get]
  match '/en', to: 'static_pages#home', locale: 'en', via: [:get]
end
