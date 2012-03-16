xml.instruct!
xml.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
  @sitemap.urls.each do |url|
    xml.url do
      xml.loc url.loc
      xml.lastmod url.lastmod       if url.lastmod
      xml.changefreq url.changefreq if url.changefreq
      xml.priority url.priority     if url.priority
    end
  end
end