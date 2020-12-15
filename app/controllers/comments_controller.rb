class CommentsController < ApplicationController

  def create
    map_find
    @comment = Comment.new(comment_params)
    if @comment.save
      ja_time = l @comment.created_at
      ActionCable.server.broadcast 'comment_channel', text: @comment, user: @comment.user.name, time: ja_time 
    else
      @post = Post.new
      @comment = Comment.new
      @posts = @map.posts.includes(:user)
      @comments = @map.comments.includes(:user)
      render template: "maps/show" 
    end
  end

private
  def comment_params
    params.require(:comment).permit(:content).merge(map_id: params[:map_id], user_id: current_user.id)
  end

  def map_find
    @map = Map.find(params[:map_id])
  end
end
