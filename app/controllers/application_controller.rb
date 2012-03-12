class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  before_filter :ensure_domain
  before_filter :set_locale, :except => :change_locale

  APP_DOMAIN = 'www.luleka.com'

  layout 'slide'
  
  protected
  
  def ensure_domain
    if Rails.env.production? && request.env['HTTP_HOST'] != APP_DOMAIN
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
  # should probably be recalled to -> slider?
  def slide?
    !!@slide
  end
  helper_method :slide?
  
  def modal?
    !!@modal
  end
  helper_method :modal?

  def set_locale
    I18n.locale = current_locale || request.compatible_language_from(I18n.available_locales)
    logger.debug "* current_locale '#{current_locale}'"
    logger.debug "* I18n.locale set to '#{I18n.locale}'"
  end
  
  def current_locale
    @current_locale ||= (locale_from_params || locale_from_session || locale_from_cookie) unless @current_locale == false
  end
  helper_method :current_locale

  def current_locale=(new_locale)
    session[locale_param] = new_locale
    logger.debug "** current_locale= session['#{locale_param}'] = '#{new_locale}'"
    cookies[cookie_auth_token] = {:value => new_locale, :expires => Time.now + 1.year}
    logger.debug "** current_locale= cookies['#{cookie_auth_token}'] = #{{:value => new_locale, :expires => Time.now + 1.year}.inspect}"
    @current_locale = new_locale || false
  end

  def locale_from_params
    if params[:locale] && I18n.active_locale_languages.include?(params[:locale].to_s)
      logger.debug "** locale_from_params '#{params[:locale]}'"
      params[:locale]
    end
  end

  def locale_from_session
    logger.debug "** locale_param '#{locale_param}'"
    logger.debug "** locale_from_session '#{session[locale_param].inspect}'"
    self.current_locale = session[locale_param] if session[locale_param]
  end

  def locale_from_cookie
    logger.debug "** cookie_auth_token '#{cookie_auth_token}'"
    token = cookies[cookie_auth_token]
    if token
      locale = cookies[cookie_auth_token] = {
        :value => locale,
        :expires => Time.now + 1.year
        # :domain => "domain.com"
      }
      logger.debug "** locale_from_cookie '#{locale[:value].inspect}'"
      self.current_locale = locale[:value]
    else
      nil
    end
  end
  
  def locale_param
    :canonical_locale
  end
  
  def cookie_auth_token
    "#{locale_param}_auth_token".to_sym
  end
  
  # Override in controllers
  def active_locale_languages
    [:en]
  end
  helper_method :active_locale_languages
  
end
