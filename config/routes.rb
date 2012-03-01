Nl::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :registrations, :only => :create
  
  root :to => "pages#splash"
  match "home" => "pages#index"
  match "pages/change_locale" => "pages#change_locale", :method => :post, :as => "change_locale"

  get  "/social/campaign" => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign" => "social/campaigns#show", :as => :social_campaign
  post "/social/registrations" => "social/registrations#create", :as => :social_registrations
  get  "/social/signup" => "social/registrations#new", :as => :new_social_registration
  get  "/social/referral" => "social/referrals#show", :as => :referral
  get  "/social/invite" => "invitations#new", :as => :new_social_invitation
  post "/social/events" => "social/events#create", :as => :social_events
end
