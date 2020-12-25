class PostsController < ApplicationController
  def create
    @map = Map.find(params[:map_id]) 
    @post = Post.new(post_params)
    if @post.save
      redirect_to "/maps/#{@post.map.id}"
    else
    
      @comment = Comment.new
      @posts = @map.posts.includes(:user).page(params[:page]).per(10)
      @comments = @map.comments.includes(:user)
      render template: "maps/show"
    end 
  end

  private
  def post_params
    params.require(:post).permit(:content, :evaluation_id, images: []).merge(map_id: params[:map_id], user_id: current_user.id)
  end

end
