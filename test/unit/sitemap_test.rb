require 'test_helper'

class SitemapTest < ActiveSupport::TestCase
  def urlset
    @urlset ||= Sitemap.new.urlset
  end

  test "should return a urlset" do
    assert_not_nil urlset
  end

  test "should return multiple urls" do
    assert urlset.any?
  end

  test "should return well-formed urls" do
    urlset.each do |url|
      assert_nothing_raised { URI.parse(url.loc) }
    end
  end

  test "should return http urls" do
    urlset.each do |url|
      assert_kind_of URI::HTTP, URI.parse(url.loc)
    end
  end
end
