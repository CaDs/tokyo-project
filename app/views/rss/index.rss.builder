xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.link uri("/")
    xml.description "Visions of Tokyo. A lonely alley, a crowded street, a field full of cherry blossoms, there is magic on every corner of this city."
    pictures = @cached_pictures
    pictures ||= @pictures_array
    pictures.each do |p|
      picture = p[0]
      vision = p[1]
      xml.item do
        picture_url = uri url(:visions, :show, id: "#{vision.id}", pid: picture.id)
        xml.title   vision.title
        xml.description "<p>#{image_tag(picture.medium)}</p><p>A new picture has been added to #{vision.title}</p><br/><p>#{picture.description_en} </p>"
        xml.pubDate picture.updated_at.to_s(:rfc822)
        xml.link    picture_url
        xml.guid    picture_url
      end
    end
    posts = @cached_posts
    posts ||= @posts
    posts.each do |post|
      xml.item do
        post_url = uri url(:blog, :show, id: "#{post.id}")
        xml.title   post.title
        xml.description  post.body
        xml.pubDate post.updated_at.to_s(:rfc822)
        xml.link    post_url
      end
    end
  end
end