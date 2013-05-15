class CommentsController < ApplicationController
  load_and_authorize_resource :content_piece, :instance_name => :commentable, :except => [:create]
  load_and_authorize_resource :comment, :through => :content_piece, :except => [:create]
  
  respond_to :json

  def show
  end

  def index
  end

  def create
    @commentable = ContentPiece.find(params[:commentable_id])
    @comment = @commentable.comments.build :user_id => current_user.id, :text => params[:content]
    @comment.save
  end

  def destroy
    @comment.destroy
  end
end
