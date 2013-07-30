xml.instruct! :xml, :encoding => "UTF-8"
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
)do
  @urls.each do |url|
    xml.url do |url_tag|
      url_tag.loc url
      url_tag.changefreq "daily"
    end
  end
end