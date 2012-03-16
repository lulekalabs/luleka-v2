module ApplicationHelper
  
  def page_title
    t "site.title"
  end
  
  def language_links
    html = "".html_safe
    locales = active_locale_languages
    locales.each_with_index do |locale, index|
      if I18n.locale == locale
        html += content_tag(:em, t("languages.#{I18n.locale_language}"), :class => "current")
      else
        html += link_to(I18n.switch_locale(locale) {t("languages.#{I18n.locale_language(locale)}").titleize}, 
          root_with_locale_path(:locale => I18n.locale_language(locale)), # url_for({:locale => I18n.locale_language(locale)}),
            :title => t("languages.#{I18n.locale_language(locale)}").titleize, "data-locale" => locale)
      end
      unless index == locales.size - 1
        html += '<span class="dot"> &middot; </span>'.html_safe
      end
    end
    html
  end
  
end
