class Social::SocialApplicationController < ApplicationController
  before_filter :set_p3p_headers
  before_filter :find_campaign

  layout "social"
  
  protected
  
  def set_p3p_headers
    response.headers["P3P"] = 'CP="HONK"'
  end
  
  def inside_facebook?
    params[:signed_request].present?
  end
  helper_method :inside_facebook?

  def inside_standalone_app?
    false
  end
  helper_method :inside_standalone_app?
  
  def find_campaign
    @campaign = Campaign.first
    campaign_session = @campaign.session
    campaign_session.request = request
    campaign_session.process_signed_request
  end
  
end
