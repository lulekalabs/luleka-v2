module Social::SocialApplicationHelper

  def page_title
    @campaign ? @campaign.name : super
  end

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
    logger.debug "* Signed request/inside facebook? '#{@campaign.session.signed_request?}'"
    @campaign.session.signed_request?
  end

  def inside_standalone_app?
    false
  end
  
  def body_id
    @body_id || "social"
  end
  
  def change_locale_path
    social_change_locale_path
  end

end