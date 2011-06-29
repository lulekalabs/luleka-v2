class PeopleController < ApplicationController
  before_filter :load_person
  
  def index
  end
  
  def show
    @posts = Post.all
  end
  
  protected
  
  def load_person
    @person = Person.find_by_last_name(params[:id])
  rescue ActiveRecord::RecordNotFound
    @person = nil
  end
end
