class Social::SocialApplicationController < ApplicationController
  before_filter :set_p3p_headers
  before_filter :find_campaign

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
  
end
