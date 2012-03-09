class Social::RegistrationsController < Social::SocialApplicationController
  before_filter :already_registered
  
  def new
    @registration = Social::Registration.new
  end

  def create
    logger.debug "** params #{params.inspect}"
    @registration = Social::Registration.new(params[:social_registration]) do |r|
      r.ip_address   = request.remote_ip
      r.referrer_uid = @campaign.session.referrer
    end

    if @registration.valid?
      @registration.save
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
  
  protected
  
  def already_registered
    if @campaign.session && @campaign.session.registration_id
      logger.debug "** @campaign.session.registration_id #{@campaign.session.registration_id.inspect}"
      redirect_to new_social_invitation_path
    end
  end
  
end
