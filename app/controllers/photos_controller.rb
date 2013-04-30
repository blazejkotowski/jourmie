class PhotosController < ApplicationController
  load_and_authorize_resource :photo
  respond_to :json, :html
  
  def show
  end
  
  def index
  end
  
  def create
    @photo = Photo.new(params[:photo].merge({ :user => current_user }))
    @photo.save
  end
  
  def update
  end
  
  def destroy
    @success = @photo.delete
  end
end
