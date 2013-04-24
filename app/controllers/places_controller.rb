class PlacesController < ApplicationController
  load_and_authorize_resource :place
  
  def show
  end
  
  def create
    @place = Place.new params[:place]
    if @place.save
      @created = true
    else
      @created = false
    end
    respond_to :json
  end
  
  def update
  end
  
  def destroy
  end

end
