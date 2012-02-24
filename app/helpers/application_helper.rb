module ApplicationHelper
  
  def language_links
    html = "".html_safe
    available_locales = I18n.available_locales.reject {|l| l == :"i18n"}
    available_locales.each_with_index do |locale, index|
      if I18n.locale == locale
        html += content_tag(:em, t("languages.#{I18n.locale_language}"), :class => "current")
      else
        html += link_to(t("languages.#{I18n.locale_language(locale)}"), "")
      end
      html += '<span class="dot"> &middot; </span>'.html_safe
    end
    html
  end

end
