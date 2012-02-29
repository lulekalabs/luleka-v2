# I18n core extensions of functionality formerly available in Globalize1
module I18n
  module Extensions
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      # Allows you to switch the current locale while within the block.
      # The previously current locale is reset after the block is finished.
      #
      # E.g
      #
      #     I18n.locale = :'en-US'
      #     I18n.switch_locale :'es-ES' do
      #       product.name = 'esquis'
      #     end
      #
      #     product.name #   --> skis
      #
      def switch_locale(code)
        current_locale = I18n.locale
        I18n.locale = code
        result = yield
        I18n.locale = current_locale
        result
      end
      alias_method :with_locale, :switch_locale   # make it more Globalize2 like

      # Returns true if the currently set locale is the default_locale
      # this is analogous to Globalize Locale.base?
      def default_locale?
        I18n.default_locale == I18n.locale
      end

      # Returns the language specific portion of the locale as code symbol
      #
      # E.g.
      #
      #   :de-DE     I18n.locale_language -> :de
      #   :en        I18n.locale_language -> :en
      #   :"it-IT"   I18n.locale_language -> :it
      #
      def locale_language(locale=nil)
        "#{locale || I18n.locale}"[0, 2].to_sym
      end

      # Returns the country specific portion of locale as code symbol
      #
      # E.g.
      #
      #   :de-DE     I18n.locale_country_code  -> :DE
      #   :en        I18n.locale_country_code  -> nil
      #   :"it-IT"   I18n.locale_country_code -> :IT
      #
      def locale_country(locale=nil)
        "#{locale || I18n.locale}".match(/-([a-zA-Z]{2})/) ? $1.to_sym : nil
      end
      
      def active_locales
        I18n.fallbacks.reject {|k,v| k.to_s.length < 2}.keys.compact.uniq
      rescue Exception => ex
        raise "I18n.fallbacks must be setup to determine active locales"
      end

      def active_locale_languages
        active_locales.map {|l| locale_language(l)}.compact.uniq
      end
      
      # Right-to-left language? E.g. Hebrew or Arabic
      def rtl?
        t("site.direction", :default => "ltr") == "rtl"
      end
      
    end
  end
end
I18n.send :include, I18n::Extensions