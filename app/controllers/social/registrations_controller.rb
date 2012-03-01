class Social::RegistrationsController < Social::SocialApplicationController
  
  def new
    @registration = Social::Registration.new
  end

  def create
    @registration = Social::Registration.new(params[:registration]) do |r|
      r.ip_address   = request.remote_ip
      r.referrer_uid = @campaign.session.referrer
      r.videos << @campaign.session.video
    end
    if @registration.save
      @campaign.session.update registration_id: @registration.id
      redirect_to new_social_invitation_path
    else
      render :new
    end
  end
  
end
