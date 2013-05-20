Jourmie::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resource :user_profiles, :as => "profile", :path => "profile", :only => [:edit, :update]
  resources :user_profiles, :as => "profiles", :path => "profiles", :only => [:show] do
    resources :albums, :only => [:index]
    resources :friendships, :only => [:index] do
      put 'accept', :on => :collection
      put 'reject', :on => :collection
    end
  end
  
  resources :friendships, :only => [:create, :destroy]
  
  resources :albums do
    resources :participations, :only => [:create, :destroy]
    get :s3_upload_form, :on => :collection
  end
  resources :places
  resources :roads
  resources :photos
  
  resources :content_pieces do
    resource :comments, :only => [:create, :show, :destroy, :index]
  end
  
  root :to => "static_pages#home"

  match "about" => "static_pages#about", :as => :about

  match '/:anything', :to => "static_pages#not_found", :constraints => { :anything => /.*/ }

end
