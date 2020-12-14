class MapsController < ApplicationController

def index
  @maps = Map.all
  gon.maps = Map.all
end

def show
  @map = Map.find(params[:id])
  @post = Post.new
  @posts = @map.posts
  @comment = Comment.new
  @comments = @map.comments
end

end
