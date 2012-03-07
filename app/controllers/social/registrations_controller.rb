class Social::RegistrationsController < Social::SocialApplicationController
  
  def new
    @registration = Social::Registration.new
  end

  def create
    @registration = Social::Registration.new(params[:social_registration]) do |r|
      r.ip_address   = request.remote_ip
      r.referrer_uid = @campaign.session.referrer
    end

    if @registration.save
      @campaign.session.update registration_id: @registration.id
      respond_to do |format|
        format.js
        format.html do
          redirect_to new_social_invitation_path
        end
      end
    else
      render "new"
    end
  end
  
end
