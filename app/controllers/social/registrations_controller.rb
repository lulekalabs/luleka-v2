class Social::RegistrationsController < Social::SocialApplicationController
  
  def new
    @registration = SocialBuilder::Registration.new

    SocialBuilder::Event.create_from! request,
      :event_code => "landing_page_view",
      :viral      => !! @campaign.session.referrer
  end

  def create
    @registration = SocialBuilder::Registration.new(params[:registration]) do |r|
      r.ip_address   = request.remote_ip
      r.referrer_uid = @campaign.session.referrer
      r.videos << @campaign.session.video
    end
    if @registration.save
      @campaign.session.update registration_id: @registration.id
      SocialBuilder::Event.create_from! request,
        :event_code => @campaign.session.video.source == "webcam" ? "video_recording" : "video_upload"
      flash[:video_id] = false
      @campaign.session.video.viddler_update!
      @campaign.session.update video_id: nil
      redirect_to new_invitation_path
    else
      render :new
    end
  end
  
end
