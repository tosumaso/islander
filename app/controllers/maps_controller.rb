class MapsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

def index
  @maps = Map.all
  gon.maps = Map.all
end

def show
  @map = Map.find(params[:id])
  @post = Post.new
  @posts = @map.posts.includes(:user)
  @comment = Comment.new
  @comments = @map.comments.includes(:user)
end

end
