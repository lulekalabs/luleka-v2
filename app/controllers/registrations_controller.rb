class RegistrationsController < ApplicationController
  
  def create
    @registration = Registration.create({
      :language_code => "#{I18n.locale_language}",
      :country_code  => "#{I18n.locale_country}",
      :ip_address    => request.remote_ip
    }.merge((params[:registration] || {}).symbolize_keys))
    respond_to do |format|
      format.js {  }
      format.html { 
        redirect_to root_path(:registered => true)
        return
      }
    end
  end
  
end
