class Api::V1::PostsController < Api::V1::BaseController

  before_action :authenticate_user
  before_action :authorize_user
  before_action :authorize_user_for_post, only: [:update]

  def create
    topic = Topic.find(params[:topic_id])
    post = topic.posts.build(post_params)
    post.user = @current_user

    if post.valid?
      post.save!
      post.labels = Label.update_labels(params[:post][:labels])
      render json: post, status: 201
    else
      render json: {error: "Post is invalid", status: 400}, status: 400
    end
  end

  def update
    post = Post.find(params[:id])

    if post.update_attributes(post_params)
      render json: post, status: 200
    else
      render json: {error: "Post update failed", status: 400}, status: 400
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: {message: "Post destroyed", status: 200}, status: 200
    else
      render json: {error: "Post destroy failed", status: 400}, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user_for_post
    post = Post.find(params[:id])
    unless @current_user == post.user || @current_user.admin?
      render json: { error: "Not Authorized for Post", status: 403 }, status: 403
    end
  end

end
