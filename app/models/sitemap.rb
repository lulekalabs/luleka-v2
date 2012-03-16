class Sitemap
  include Rails.application.routes.url_helpers

  # TODO: make host a param for initialize, so that we can pass it from the
  # request itself. Consider also passing the controller object so that we can
  # invoke helpers on the controller object.
  self.default_url_options = {:host => "www.luleka.com"}

  Url = Struct.new(:loc, :lastmod, :changefreq, :priority)

  attr_reader :urlset

  def initialize
    @urlset = []

    urlset << Url.new(root_url)
    urlset << I18n.active_locale_languages.map {|locale| Url.new(root_with_locale_url(:locale => I18n.locale_language(locale)))}

    urlset.flatten!
  end

  alias :urls :urlset
end