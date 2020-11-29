class Api::V1::PostsController < ApiController  
  before_action :authenticate_user!, only: [:create]
  def index
    post_items = Post.all
    render json: {
      post_items: serialized_data(post_items, PostSerializer)
    }
  end

  def create
    new_post = Post.new(post_params)
    new_post.user = current_user 
    if new_post.save
      render json: new_post
    else
      render json: { errors: new_post.errors }
    end
  end
  private 


  def post_params
    params.require(:post).permit([:body])
  end
  def serialized_data(data, serializer)
    ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer, scope: current_user)
  end
end 