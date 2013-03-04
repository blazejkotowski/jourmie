Jourmie::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resource :user_profiles, :as => "profile", :path => "profile", :only => [:edit, :update]
  resources :user_profiles, :as => "profiles", :path => "profiles", :only => [:show]
  
  root :to => "static_pages#home"
end
