module Social::SocialApplicationHelper

  def date_format(datetime)
    datetime.strftime("%b %d, %Y %H:%M")
  end

  def session_data
    return {
      :context => {
        :referrer_uid    => @campaign.session.referrer,
        :page_id         => @campaign.session.page_id || @campaign.page_id,
        :registration_id => @campaign.session.registration_id
      },
      :campaign => @campaign.page_data.merge({
        :registration_path   => registrations_path,
        :tracking_event_path => social_events_path,
        :referral_url        => referral_url,
        :liked               => @campaign.session.liked?
      })
    }
  end

  def inside_facebook?
    params[:signed_request].present?
  end

  def inside_standalone_app?
    false
  end

end