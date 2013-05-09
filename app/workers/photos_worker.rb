class PhotosWorker
  include Sidekiq::Worker
  def perform photo_id, photo_url
    p = Photo.find(photo_id)
    p.update_attributes :remote_file_url => photo_url
    Rails.logger.info "Performed photo #{photo_id} with url #{photo_url}"
  end
end
