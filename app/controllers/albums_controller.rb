class AlbumsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :new, :create]
  load_and_authorize_resource :except => [:cover, :new, :create]

  def index
    @albums = current_user.albums
  end
  
  def show
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def edit
  end
  
  def update
    @saved = false
    if @album.update_attributes params[:album]
      @saved = true
    end
    respond_to :json
  end
  
  def new
    @album = Album.new(:key => params[:key], 
                      :start_date => Date.today, 
                      :end_date => (Date.today + 7.days) )
#    @cover_uploader = @album.cover_image
#    @cover_uploader.success_action_redirect = new_album_url
  end
  
  def create
    @album = current_user.albums.new(params[:album])
    unless @album.save
      render "new"
    else
      redirect_to edit_album_url(@album)
    end
  end
  
  def create_content
    
  end
  
end
