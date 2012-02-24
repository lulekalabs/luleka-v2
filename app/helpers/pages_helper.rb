module PagesHelper
  
  def page_title
    "#{t "site.title"} - #{t "site.tagline"}"
  end
  
  def registered?
    !!params[:registered]
  end
end
