class Api::V1::PostsController < ApiController  
  before_action :authenticate_user, only: [:create]
  def index
    posts = Post.all
    render json: posts
  end
end 