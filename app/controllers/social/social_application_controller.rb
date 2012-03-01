class Social::SocialApplicationController < ApplicationController
  before_filter :set_p3p_headers

  layout "social"
  
  protected
  
  def set_p3p_headers
    response.headers["P3P"] = 'CP="HONK"'
  end
  
end
