class RegistrationsController < ApplicationController
  
  def create
    @registration = Registration.instance_for(params[:registration], {
      :language_code => "#{I18n.locale_language}",
      :ip_address    => request.remote_ip
    }, request.location ? request.location.data : {})
    @registration.save
    respond_to do |format|
      format.js {}
      format.html { 
        redirect_to root_path(:registered => true)
        return
      }
    end
  end
  
end
