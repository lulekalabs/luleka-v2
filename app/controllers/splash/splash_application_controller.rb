class Splash::SplashApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :change_locale
  layout "splash_application"

  def index
  end

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    logger.debug "* Current locale set to '#{current_locale}'"
    redirect_to params[:redirect] || "/"
    return
  end
  
  protected
  
  include Splash::SplashApplicationHelper

  def active_locale_languages
    I18n.active_locale_languages
  end

  def locale_param
    :splash_locale
  end
end
