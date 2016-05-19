class CommentsController < ApplicationController

  before_action :require_sign_in
  before_action :identify_commentable, only: [:create, :destroy]
  before_action :authorize_user, only: [:destroy]


  def create
    # if params[:post_id]
    #   @commentable = Post.find(params[:post_id])
    #   comment = @commentable.comments.new(comment_params)
    #   comment.user = current_user
    #   @redirect_path = [@commentable.topic, @commentable]
    # elsif params[:topic_id]
    #   @commentable = Topic.find(params[:topic_id])
    #   comment = @commentable.comments.new(comment_params)
    #   comment.user = current_user
    #   @redirect_path = @commentable
    # end

    comment = @commentable.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to @redirect_path
    else
      flash[:alert] = "Comment failed to save."
      redirect_to @redirect_path
    end



  end

  def destroy
    # if params[:post_id]
    #   @commentable = Post.find(params[:post_id])
    #   @redirect_path = [@commentable.topic, @commentable]
    # elsif params[:topic_id]
    #   @commentable = Topic.find(params[:topic_id])
    #   @redirect_path = @commentable
    # end

    comment = @commentable.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to @redirect_path
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to @redirect_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def identify_commentable
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
      # comment = @commentable.comments.new(comment_params)
      # comment.user = current_user
      @redirect_path = [@commentable.topic, @commentable]
    elsif params[:topic_id]
      @commentable = Topic.find(params[:topic_id])
      # comment = @commentable.comments.new(comment_params)
      # comment.user = current_user
      @redirect_path = @commentable
    end
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      if params[:post_id]
        redirect_to [comment.commentable.topic, comment.commentable]
      elsif params[:topic_id]
        redirect_to comment.commentable
      end

    end
  end



end
