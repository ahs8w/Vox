Vox::Application.routes.draw do
  root :to => "home#index"

  devise_for :users
  
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  resources :posts do
    get 'news', :on => :collection
    get 'writing', :on => :collection
    get 'commentary', :on => :collection
    get 'meditations', :on => :collection
    get 'travel', :on => :collection
    get 'images', :on => :collection
    resources :ratings, :only => [:create, :new]
    resources :comments 
  end

  resources :images, :only => [:new, :show, :create]
     
  resources :comments, :only => [] do
    resources :ratings, :only => [:create, :new]
  end

  get 'feed', to: 'posts#index', as: :feed
  get '/:id', to: 'profiles#show', as: :profile
  get "profiles/show"
end