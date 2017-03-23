xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.link uri("/")
    xml.description "Visions of Tokyo. A lonely alley, a crowded street, a field full of cherry blossoms, there is magic on every corner of this city."
    pictures = @cached_pictures
    pictures.each do |p|
      picture_url = uri url(:visions, :show, id: "#{p.vision_id}", pid: p.id)
      xml.item do
        xml.title   p.vision.title
        xml.description "<p>#{image_tag(p.medium)}</p><p>A new picture has been added to #{p.vision.title}</p><br/><p>#{p.description_en} </p>"
        xml.pubDate p.updated_at.to_s(:rfc822)
        xml.link    picture_url
        xml.guid    picture_url
      end
    end
    posts = @cached_posts
    posts.each do |post|
      xml.item do
        post_url = uri url(:blog, :show, id: "#{post.id}")
        xml.title  post.title
        xml.description post.body
        xml.pubDate post.updated_at.to_s(:rfc822)
        xml.link    post_url
      end
    end
  end
end
