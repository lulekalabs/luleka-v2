class Account::AccountApplicationController < ApplicationController
  before_filter :set_body_dom_id
  
  layout 'nl/single'
  
  protected
  
  def set_body_dom_id
    @body_dom_id = "settings"
  end
end
