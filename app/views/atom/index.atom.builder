xml.instruct!
xml.feed  xmlns: "http://www.w3.org/2005/Atom" do
  xml.title   "Tokyo Project"
  xml.link    "rel" => "self", "href" => url_for('/')
  xml.id      uri("/")
  xml.updated @pictures.first.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ" if @pictures.any?
  xml.author  { xml.name @pictures.first.vision.account.role }

  @pictures.each do |picture|
    xml.entry do
      picture_url = uri url(:places, :show, id: "#{picture.vision.id}", pid: picture.id)
      xml.title   picture.vision.title
      xml.link    rel: "alternate", href: picture_url
      xml.id      picture_url
      xml.updated picture.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author  { xml.name picture.vision.account.role  }
      xml.summary "A new picture has been added to #{picture.vision.title} #{picture.description_en}"
    end
  end
end
