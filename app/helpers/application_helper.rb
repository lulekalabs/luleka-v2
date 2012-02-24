module ApplicationHelper
  
  def page_title
    t "site.title"
  end
  
  def language_links
    html = "".html_safe
    available_locales = I18n.available_locales
    available_locales.each_with_index do |locale, index|
      if I18n.locale == locale
        html += content_tag(:em, t("languages.#{I18n.locale_language}"), :class => "current")
      else
        html += link_to(I18n.switch_locale(locale) {t("languages.#{I18n.locale_language(locale)}")}, 
          url_for({:locale => I18n.locale_language(locale)}),
            :title => t("languages.#{I18n.locale_language(locale)}"), "data-locale" => locale)
      end
      unless index == available_locales.size - 1
        html += '<span class="dot"> &middot; </span>'.html_safe
      end
    end
    html
  end
  
  # Javascript for google analytics
  def ga_async_javascript(id)
    <<-JS
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '#{id}']);
_gaq.push(['_setDomainName', '.luleka.com']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script');
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  ga.setAttribute('async', 'true');
  document.documentElement.firstChild.appendChild(ga);
})();
    JS
  end

  # wraps ga code in a script tag
  def ga_async_javascript_tag(id)
    javascript_tag(ga_async_javascript(id)) if Rails.env.production?
  end
  

end
