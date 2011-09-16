class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery

  layout 'slide'
  
  protected
  
  # should probably be recalled to -> slider?
  def slide?
    !!@slide
  end
  helper_method :slide?
  
  def modal?
    !!@modal
  end
  helper_method :modal?

end
