class SessionsController < ApplicationController

  before_filter :set_body_dom_id
  
  layout "nl/form"
  
  def new
    @modal = false
  end

  protected
  
  def set_body_dom_id
    @body_dom_id = "signin"
    @body_dom_class = "route-login logged-out"
  end
  
end
