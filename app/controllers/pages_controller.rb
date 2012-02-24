class PagesController < ApplicationController
  before_filter :set_body_dom_id

  def index
    render :layout => "front"
  end
  
  def splash
    render :layout => "splash"
  end

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    redirect_to params[:redirect] || "/"
    return
  end

  protected

  def set_body_dom_id
    @body_dom_id = "single"
  end

end
