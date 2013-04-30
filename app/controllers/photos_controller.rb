class PhotosController < ApplicationController
  load_and_authorize_resource :photo
  respond_to :json, :html
  
  def create
    @photo = Photo.new(:file => params[:file], :user => current_user)
    @photo.save
  end
  
  def update
  end
  
  def destroy
    @success = @photo.delete
  end
end
