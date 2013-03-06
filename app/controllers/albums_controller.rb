class AlbumsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  load_and_authorize_resource :except => [:cover, :new, :create]
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def new
    @album = Album.new(:key => params[:key])
    @cover_uploader = @album.cover_image
    @cover_uploader.success_action_redirect = new_album_url
  end
  
  def create
  end
  
end
