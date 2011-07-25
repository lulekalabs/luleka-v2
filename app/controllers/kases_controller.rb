class KasesController < ApplicationController
  before_filter :load_kase
  before_filter :settings

  def index
    @posts = [] # Kase.all
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
    @page_title = "What is your question?"
    @front_page = false
    #@active_sidebar = "dashboard-top-area"
    @active_sidebar = "dashboard-footer-area"
  end

  def load_kase
    #@kase = Kase.find(params[:id])
    # @responses = Post.all
  rescue ActiveRecord::RecordNotFound
    @kase = nil
  end
end
