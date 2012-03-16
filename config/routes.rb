Nl::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resource :sitemap, :only => :show

  # splash app
  match "/:locale" => "splash/pages#index", :as => :root_with_locale
  namespace :splash do
    resources :registrations, :only => :create
  end
  root :to => "splash/pages#index"
  post "splash/session/change_locale"   => "splash/splash_application#change_locale", :as => "splash_change_locale"

  # social app
  get  "/social/campaign"               => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign"               => "social/campaigns#show", :as => :social_campaign
  post "/social/campaign/registrations" => "social/registrations#create", :as => :social_registrations
  get  "/social/campaign/signup"        => "social/registrations#new", :as => :new_social_registration
  get  "/social/campaign/referral"      => "social/referrals#show", :as => :referral
  get  "/social/campaign/invite"        => "social/invitations#new", :as => :new_social_invitation
  post "/social/campaign/events"        => "social/events#create", :as => :social_events
  get  "/social/campaign/over"          => "social/campaigns#over", :as => :social_campaign_over
  get  "/sweepstakes/rules"             => "social/campaigns#rules", :as => :social_campaign_rules
  post "social/session/change_locale"   => "social/splash_application#change_locale", :as => "social_change_locale"

  # app
  # match "home" => "pages#index"

end
