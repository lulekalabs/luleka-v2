class ResponsesController < ApplicationController
  before_filter :load_kase
  
  #--- index

  def new
    @responses = Post.recent(3)
  end
  
  protected
  
  def load_kase
    @kase = Post.find(params[:kase_id])
    @responses = Post.all
  rescue ActiveRecord::RecordNotFound
    @kase = nil
  end
end
