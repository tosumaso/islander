class CommentsController < ApplicationController

  def create
    @map = Map.find(params[:map_id])
    comment = Comment.create(comment_params)
    redirect_to "/maps/#{comment.map_id}"
  end

private
  def comment_params
    params.require(:comment).permit(:content).merge(map_id: params[:map_id], user_id: current_user.id)
  end
end
