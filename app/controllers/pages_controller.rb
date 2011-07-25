class PagesController < ApplicationController
  before_filter :set_body_dom_id
  layout :determine_layout

  def index
  end

  def about
  end

  protected

  def set_body_dom_id
    @body_dom_id = "single"
  end

  def determine_layout
    action_name =~ /index/ ? "front" : "single"
  end

end
