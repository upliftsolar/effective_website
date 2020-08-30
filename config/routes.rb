require_relative '../lib/effective_pages_constraint_override'
Rails.application.routes.draw do
  mount Tolk::Engine => '/tolk', :as => 'tolk'
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

  resources :leads
  resource :questions do #, only: [:index,:new,:create] do
    post :increment, on: :member
  end

  #without this, i18n doesn't work well for Pages
  #effective pages
  scope :module => 'effective' do
    get '*id', to: 'pages#show', constraints: ::EffectivePagesConstraint, as: :page
  end
  #effective posts
  scope :module => 'effective' do
    categories = Array(EffectivePosts.categories).map { |cat| cat.to_s unless cat == 'posts'}.compact
    onlies = ([:index, :show] unless EffectivePosts.submissions_enabled)

    if EffectivePosts.use_blog_routes
      categories.each do |category|
        match "blog/category/#{category}", to: 'posts#index', via: :get, defaults: { category: category }
      end

      resources :posts, only: onlies, path: 'blog'
    elsif EffectivePosts.use_category_routes
      categories.each do |category|
        match category, to: 'posts#index', via: :get, defaults: { category: category }
        match "#{category}/:id", to: 'posts#show', via: :get, defaults: { category: category }
      end

      resources :posts, only: onlies
    else
      resources :posts, only: onlies
    end
  end


  
  acts_as_archived

  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions', 
    confirmations: 'users/confirmations', 
    invitations: 'users/invitations' 
  }
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
  match '/contact', to: 'leads#new', via: [:get]

  namespace :admin do
    resources :questions, except: [:show]
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

    resources :questions

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
