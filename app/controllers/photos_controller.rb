class PhotosController < ApplicationController
  load_and_authorize_resource :photo
  respond_to :json, :html
  
  def show
  end
  
  def index
  end
  
  def create
    remote_file_url = params[:remote_file_url]
    params[:remote_file_url] = nil
    @photo = Photo.new(params[:photo].merge({ :user => current_user }))
    if @photo.save
      PhotosWorker.perform_async(@photo.id, remote_file_url)
    end
  end
  
  def update
    @photo.update_attributes params[:photo]
    render :show
  end
  
  def destroy
    @success = @photo.delete
  end
end
