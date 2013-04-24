class RoadsController < ApplicationController
  load_and_authorize_resouce :road
  
  def create
    @road = Road.new params[:road]
    if @road.save
      @created = true
    else
      @created = false
    end
    respond_to :json
  end
  
  
end
