class PagesController < ApplicationController
  before_filter :set_body_dom_id

  def index
    render :layout => "front"
  end
  
  def splash
    render :layout => "splash"
  end

  def about
    render :layout => "single"
  end

  protected

  def set_body_dom_id
    @body_dom_id = "single"
  end

end
