require "i18n/backend/fallbacks" 
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

I18n.fallbacks[:en] = [:en]
I18n.fallbacks[:de] = [:de, :en]
I18n.fallbacks[:es] = [:es, :en]
I18n.fallbacks[:pt] = [:pt, :en]
I18n.fallbacks[:it] = [:it, :en]
I18n.fallbacks[:fr] = [:fr, :en]
I18n.fallbacks[:nl] = [:nl, :en]
I18n.fallbacks[:pl] = [:pl, :en]
I18n.fallbacks[:tr] = [:tr, :en]