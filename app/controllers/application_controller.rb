class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  before_filter :ensure_domain
  before_filter :set_locale

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
    logger.debug "* Current locale set to '#{current_locale}'"
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
  def current_locale
    @current_locale ||= (locale_from_session || locale_from_cookie) unless @current_locale == false
  end
  helper_method :current_locale

  def current_locale=(new_locale)
    session[locale_param] = new_locale
    cookies[cookie_auth_token] = {:value => new_locale, :expires => Time.now + 1.year}
    @current_locale = new_locale || false
  end

  def locale_from_session
    self.current_locale = session[locale_param] if session[locale_param]
  end

  def locale_from_cookie
    locale = cookies[cookie_auth_token]
    if locale
      cookies[cookie_auth_token] = {
        :value => locale,
        :expires => Time.now + 1.year
        # :domain => "domain.com"
      }
      self.current_locale = locale
    end
  end
  
  def locale_param
    :locale
  end
  
  def cookie_auth_token
    "#{locale_param}_auth_token".to_sym
  end
end
