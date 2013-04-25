xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.link uri("/")
    xml.description "Visions of Tokyo. A lonely alley, a crowded streed, a field full of cherry blossoms, there is magic on every corner of this city."
    xml.lastBuildDate Picture.last.updated_at.to_s(:rfc822)
    xml.language "en"

    @pictures.each do |picture|
      xml.item do
        picture_url = uri url(:visions, :show, id: "#{picture.vision.id}", pid: picture.id)
        xml.title   picture.vision.title
        xml.link    picture_url
        xml.description "A new picture has been added to #{picture.vision.title} #{picture.description_en}"
        xml.pubDate picture.updated_at.to_s(:rfc822)
      end
    end
  end
end