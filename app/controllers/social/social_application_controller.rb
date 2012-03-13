class Social::SocialApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :change_locale
  skip_before_filter :ensure_domain
  prepend_before_filter :set_p3p_headers
  prepend_before_filter :find_campaign
  before_filter :ensure_rules, :except => [:over, :create]

  layout "social_application"

  def change_locale
    self.current_locale = params[:locale].to_sym if params[:locale]
    logger.debug "* current_locale changed to '#{current_locale}'"
    redirect_to params[:redirect] || "/"
    return
  end

  protected
  
  include Social::SocialApplicationHelper
  
  # Override from ApplicationController
  def set_locale
    I18n.locale = current_locale || I18n.locale_language(@campaign.session.locale.to_s) || 
      request.compatible_language_from(I18n.available_locales)
    logger.debug "** current_locale '#{current_locale}'"
    logger.debug "** session.locale '#{@campaign.session.locale}'"
    logger.debug "** request.languages '#{request.compatible_language_from(I18n.available_locales).inspect}'"
    logger.debug "** I18n.locale '#{I18n.locale}'"
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
    logger.debug "** current_session= session['#{session_param}'] = '#{new_session ? new_session.id : nil}'"
    cookies[session_cookie_token] = {:value => new_session ? new_session.id : nil, :expires => Time.now + 1.year}
    logger.debug "** current_session= cookies['#{session_cookie_token}'] = '#{new_session ? new_session.id : nil}'"
    @current_session = new_session || false
  end

  def session_from_session
    logger.debug "** session_param #{session_param.inspect}"
    logger.debug "** session_from_session session[session_param] #{session[session_param].inspect}"
    self.current_session = Social::CampaignSession.get(session[session_param]) if session[session_param]
  rescue Ambry::NotFoundError
  end

  def session_from_cookie
    logger.debug "** session_cookie_token #{session_cookie_token.inspect}"
    if token = cookies[session_cookie_token]
      logger.debug "** session_from_cookie #{token.inspect}"
      self.current_session = Social::CampaignSession.get token
    end
  rescue Ambry::NotFoundError
  end
  
  def session_param
    :canonical_session
  end
  
  def session_cookie_token
    "#{session_param}_cookie_token".to_sym
  end
  
  def locale_param
    :social_locale
  end
end
