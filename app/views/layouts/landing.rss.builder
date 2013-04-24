xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title   "Tokyo Project"
    xml.description "Visions of Tokyo. A lonely alley, a crowded streed, a field full of cherry blossoms, there is magic on every corner of this city."
    xml.link uri("/")

    @pictures.each do |picture|
      xml.item do
        picture_url = uri url(:visions, :show, id: "#{picture.vision.id}", pid: picture.id)
        xml.title   picture.vision.title
        xml.description picture.description_en
        xml.pubDate picture.updated_at.to_s(:rfc822)
        xml.link    rel: "alternate", href:  picture_url
      end
    end
  end
end