xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.link uri("/")
    xml.description "Visions of Tokyo. A lonely alley, a crowded street, a field full of cherry blossoms, there is magic on every corner of this city."

    @pictures.each do |picture|
      xml.item do
        picture_url = uri url(:visions, :show, id: "#{picture.vision.id}", pid: picture.id)
        xml.title   picture.vision.title
        xml.description "<div>A new picture has been added to #{picture.vision.title}</div><br/><div>#{image_tag(picture.thumb)}</div><div>#{picture.description_en} </div>"
        xml.pubDate picture.updated_at.to_s(:rfc822)
        xml.link    picture_url
        xml.guid    picture_url
      end
    end
    @posts.each do |post|
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