class AttachmentsController < ApplicationController
  before_filter :load_post
  before_filter :settings

  def index
    @posts = Post.all
  end
  
  def show
    respond_to do |format|
      format.js {
        render :layout => false
      }
      format.html {}
    end
  end
  
  protected
  
  def settings
    @title = "New Luleka"
    @page_title = "Attachments"
    @front_page = false
    #@active_sidebar = "dashboard-top-area"
    @active_sidebar = "dashboard-footer-area"
  end

  def load_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @post = nil
  end
end
