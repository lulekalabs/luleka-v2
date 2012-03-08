class Splash::SplashApplicationController < ApplicationController
  layout "splash_application"

  def index
  end

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    redirect_to params[:redirect] || "/"
    return
  end
  
  protected
  
  def active_locale_languages
    I18n.active_locale_languages
  end

end
