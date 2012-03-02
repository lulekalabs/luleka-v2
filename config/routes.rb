Nl::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :registrations, :only => :create

  # splash app
  root :to => "splash/pages#index"
  match "session/change_locale" => "splash/splash_application#change_locale", :method => :post, :as => "change_locale"

  # social app
  get  "/social/campaign"      => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign"      => "social/campaigns#show", :as => :social_campaign
  post "/social/registrations" => "social/registrations#create", :as => :social_registrations
  get  "/social/signup"        => "social/registrations#new", :as => :new_social_registration
  get  "/social/referral"      => "social/referrals#show", :as => :referral
  get  "/social/invite"        => "social/invitations#new", :as => :new_social_invitation
  post "/social/events"        => "social/events#create", :as => :social_events

  match "home" => "pages#index"

end
