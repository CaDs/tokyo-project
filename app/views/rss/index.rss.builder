xml.instruct!
xml.rss "version" => "2.0", "xmlns:media" => "http://search.yahoo.com/mrss/" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.link uri("/")
    xml.description "Visions of Tokyo. A lonely alley, a crowded streed, a field full of cherry blossoms, there is magic on every corner of this city."
    xml.docs "http://backend.userland.com/rss092"
    xml.lastBuildDate Picture.last.updated_at
    xml.language "en"

    @pictures.each do |picture|
      xml.item do
        picture_url = uri url(:visions, :show, id: "#{picture.vision.id}", pid: picture.id)
        xml.title   picture.vision.title
        xml.link    href:  picture_url
        xml.description "A new picture has been added to #{picture.vision.title} #{picture.description_en}"
        xml.pubDate picture.updated_at.to_s(:rfc822)
      end
    end
  end
end