class PictureJob
  include SuckerPunch::Job

  def perform(picture_id)
    ActiveRecord::Base.connection_pool.with_connection do
      picture = Picture.find(picture_id)
      picture.update_attribute(:is_published, true)
      picture.clear_cache
    end
  end

  def schedule(sec, picture_id)
    after(sec) {perform(picture_id)}
  end
end