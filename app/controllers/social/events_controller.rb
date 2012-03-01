class Social::EventsController < Social::SocialApplicationController

  def create
    @campaign_session = Campaign.first.session
    @campaign_session.request = request
    case params[:event][:event_code]
    when "liked"   then @campaign_session.update liked: true
    when "unliked" then @campaign_session.update liked: false
    else Event.create_from! request
    end
    head :created
  end

end
