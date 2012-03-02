Nl::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :registrations, :only => :create

  # splash app
  root :to => "splash/pages#index"
  match "session/change_locale" => "splash/splash_application#change_locale", :method => :post, :as => "change_locale"

  # social app
  get  "/social/campaign"               => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign"               => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign/registrations" => "social/registrations#create", :as => :social_registrations
  get  "/social/campaign/signup"        => "social/registrations#new", :as => :new_social_registration
  get  "/social/campaign/referral"      => "social/referrals#show", :as => :referral
  get  "/social/campaign/invite"        => "social/invitations#new", :as => :new_social_invitation
  post "/social/campaign/events"        => "social/events#create", :as => :social_events

  # app
  # match "home" => "pages#index"

end
