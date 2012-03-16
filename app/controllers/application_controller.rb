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
    cookies[locale_cookie_token] = {:value => new_locale, :expires => Time.now + 1.year}
    logger.debug "** current_locale= cookies['#{locale_cookie_token}'] = #{{:value => new_locale, :expires => Time.now + 1.year}.inspect}"
    @current_locale = new_locale || false
  end

  def locale_from_params
    logger.debug "** locale_from_params #{params[:locale].inspect}"
    if params[:locale] && I18n.active_locale_languages.include?(params[:locale].to_sym)
      params[:locale].to_sym
    end
  end

  def locale_from_session
    logger.debug "** locale_param #{locale_param.inspect}"
    logger.debug "** locale_from_session #{session[locale_param].inspect}"
    self.current_locale = session[locale_param] if session[locale_param]
  end

  def locale_from_cookie
    logger.debug "** locale_cookie_token #{locale_cookie_token.inspect}"
    if token = cookies[locale_cookie_token]
      logger.debug "** locale_from_cookie token #{token.inspect}"
      self.current_locale = token
    else
      nil
    end
  end
  
  def locale_param
    :canonical_locale
  end
  
  def locale_cookie_token
    "#{locale_param}_cookie_token".to_sym
  end
  
  # Override in controllers
  def active_locale_languages
    [:en]
  end
  helper_method :active_locale_languages
  
  def on_tablet?
    request.user_agent =~ /ipad|android 3|sch-i800|playbook|tablet|kindle|gt-p1000|sgh-t849|shw-m180s|a510|a511|a100|dell streak|silk/i
  end
  helper_method :on_tablet?

  def on_phone?
    request.user_agent =~ /iphone|ipod|android|blackberry|opera mini|opera mobi|skyfire|maemo|windows phone|palm|iemobile|symbian|symbianos|fennec/i
  end
  helper_method :on_phone?
  
end
