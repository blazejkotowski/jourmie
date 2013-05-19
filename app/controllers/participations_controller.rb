class ParticipationsController < ApplicationController
  load_and_authorize_resource :participation
  
  respond_to :json
  
  def create
    @participation = Participation.new(:album_id => params[:album_id], :user_id => params[:user_id])
    @participation.save
  end
  
  def destroy
    @participation = Participation.find_by_album_id_and_id(params[:album_id], params[:id])
    @participation.delete
  end
  
end
