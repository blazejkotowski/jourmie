Jourmie::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resource :user_profiles, :as => "profile", :path => "profile", :only => [:edit, :update]
  resources :user_profiles, :as => "profiles", :path => "profiles", :only => [:show] do
    resources :friendships, :only => [:index]
  end
  
  resources :friendships, :only => [:create, :destroy]
  
  resources :albums do
    get :s3_upload_form, :on => :collection
  end
  resources :places
  resources :roads
  resources :photos
  
  root :to => "static_pages#home"
end
