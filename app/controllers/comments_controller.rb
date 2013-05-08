class CommentsController < ApplicationController
  load_and_authorize_resource :comment, :through => :content_piece
  
  respond_to :json

  def index
  end

  def create
    @comment = @content_piece.comments.build params[:comment]
    @comment.save
  end

  def destroy
    @comment.destroy
  end
end
