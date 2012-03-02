class Splash::SplashApplicationController < ApplicationController
  layout "splash_application"

  def index
  end

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    redirect_to params[:redirect] || "/"
    return
  end

end
