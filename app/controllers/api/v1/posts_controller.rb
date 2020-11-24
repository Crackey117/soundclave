class Api::V1::PostsController < ApiController  
  before_action :authenticate_user, only: [:create]
  def index
    post_items = Post.all
    render json: {
      post_items: serialized_data(post_items, PostSerializer)
    }
  end

  private 
  def serialized_data(data, serializer)
    ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer, scope: current_user)
  end
end 