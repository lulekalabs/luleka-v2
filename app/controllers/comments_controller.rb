class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def new
    @comment = Comment.new
    @comments = Comment.all
  end
  
  protected
  
  def load_commentable
    if params[:kase_id]
      @commentable = @kase = Post.find(params[:kase_id])
    elsif params[:response_id]
      @commentable = @response = Post.find(params[:response_id])
    end
  rescue ActiveRecord::RecordNotFound
    @commentable = @kase = @response = nil
  end
end
