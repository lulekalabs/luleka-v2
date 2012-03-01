class Social::InvitationsController < Social::SocialApplicationController

  def new
    Social::Event.create_from! request, \
      :event_code => "view_invite_page",
      :viral      => !! @campaign.session.referrer
  end

end
