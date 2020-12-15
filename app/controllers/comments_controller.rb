class CommentsController < ApplicationController

  def create
    map_find
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/maps/#{@comment.map_id}"
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
