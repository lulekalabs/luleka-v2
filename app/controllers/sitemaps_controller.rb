class SitemapsController < ApplicationController
  def show
    @sitemap = Sitemap.new
    respond_to do |format|
      format.html { redirect_to root_path }
      format.txt
      format.xml
    end
  end
end
