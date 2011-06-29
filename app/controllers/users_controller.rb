class UsersController < ApplicationController
  before_filter :set_body_dom
  
  layout "nl/form"
  
  def new
  end
  
  protected
  
  def set_body_dom
    @body_dom_id = "signup"
    @body_dom_class = "logged-in"
  end
end
