class Social::SocialApplicationController < ApplicationController
  before_filter :set_p3p_headers
  before_filter :ensure_inside_facebook
  before_filter :find_campaign
  before_filter :ensure_rules, :except => [:over, :create]

  layout "social_application"

  protected
  
  include Social::SocialApplicationHelper
  
  def set_p3p_headers
    response.headers["P3P"] = 'CP="HONK"'
  end
  
  def find_campaign
    @campaign = Social::Campaign.first
    campaign_session = @campaign.session
    campaign_session.request = request
    campaign_session.process_signed_request
  end
  
=begin
  def set_locale
    I18n.locale = :"en"
  end
=end
  
  def ensure_inside_facebook
    if !inside_facebook? && Rails.env.production?
      redirect_to root_path, :status => :moved_permanently
      return
    end
  end

  def ensure_rules
    if @campaign.over? || @campaign.hasnt_started_yet?
      redirect_to social_campaign_over_path
      return
    end
  end

  def active_locale_languages
    [:en, :es, :de]
  end
  
end
