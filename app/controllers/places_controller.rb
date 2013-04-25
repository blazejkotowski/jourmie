class PlacesController < ApplicationController
  load_and_authorize_resource :place
  
  respond_to :json, :html
  
  def show
  end
  
  def create
    @place = Place.new params[:place]
    if @place.save
      @created = true
    else
      @created = false
    end
  end
  
  def update
    if @place.update_attributes(params[:place])
      @updated = true
    else
      @updated = false
    end
  end
  
  def destroy
  end

end
