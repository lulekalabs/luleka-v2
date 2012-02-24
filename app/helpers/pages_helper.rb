module PagesHelper
  
  def registered?
    !!params[:registered]
  end
end
