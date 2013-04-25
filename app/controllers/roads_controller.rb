class RoadsController < ApplicationController
  load_and_authorize_resource :road
  
  def create
    @road = Road.new params[:road]
    if @road.save
      @created = true
    else
      @created = false
    end
    respond_to :json
  end
  
  def update
    if @road.update_attributes(params[:road])
      @updated = true
    else
      @updated = false
    end
  end
  
end
