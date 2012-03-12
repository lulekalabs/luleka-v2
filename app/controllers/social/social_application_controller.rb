class Social::SocialApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :change_locale
  skip_before_filter :ensure_domain
  prepend_before_filter :set_p3p_headers
  prepend_before_filter :find_campaign
  before_filter :ensure_rules, :except => [:over, :create]

  layout "social_application"

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    logger.debug "* Current locale set to '#{current_locale}'"
    redirect_to params[:redirect] || "/"
    return
  end

  protected
  
  include Social::SocialApplicationHelper
  
  # Override from ApplicationController
  def set_locale
    I18n.locale = current_locale || I18n.locale_language(@campaign.session.locale.to_s) || 
      request.compatible_language_from(I18n.available_locales)
      
    puts "********************** current_locale '#{current_locale}'"
    puts "********************** session.locale '#{@campaign.session.locale}'"
    puts "********************** request.languages '#{request.compatible_language_from(I18n.available_locales).inspect}'"
    puts "********************** I18n.locale '#{I18n.locale}'"
  end
  
  def set_p3p_headers
    response.headers["P3P"] = 'CP="HONK"'
  end
  
  def find_campaign
    @campaign = Social::Campaign.first
    unless !!current_session
      self.current_session = Social::CampaignSession.find_or_create_by_id(session[:session_id]) do |session|
        session.campaign_id = @campaign.to_param 
      end
    end
    @campaign.session = current_session
    @campaign.session.request = request
    @campaign.session.process_signed_request
  end
  
  def ensure_rules
    if @campaign.over? || @campaign.hasnt_started_yet?
      redirect_to social_campaign_over_path
      return
    end
  end

  def active_locale_languages
    [:en, :es, :de]
  end
  
  def current_session
    @current_session ||= (session_from_session || session_from_cookie) unless @current_session == false
  end
  helper_method :current_session

  def current_session=(new_session)
    session[session_param] = new_session ? new_session.id : nil
    cookies[cookie_auth_token] = {:value => new_session ? new_session.id : nil, :expires => Time.now + 1.year}
    @current_session = new_session || false
  end

  def session_from_session
    self.current_session = begin
      Social::CampaignSession.get(session[session_param]) if session[session_param]
    rescue Ambry::NotFoundError
      nil
    end
  end

  def session_from_cookie
    session = begin
      cookies[cookie_auth_token] && Social::CampaignSession.get(cookies[cookie_auth_token])
    rescue Ambry::NotFoundError
      nil
    end
    if session
      cookies[cookie_auth_token] = {
        :value => session.session_id,
        :expires => Time.now + 1.year
        # :domain => "domain.com"
      }
      self.current_session = session
    end
  end
  
  def session_param
    :canonical_session
  end
  
  def cookie_auth_token
    "#{session_param}_auth_token".to_sym
  end
  
end
