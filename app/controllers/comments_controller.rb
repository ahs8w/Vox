class CommentsController < ApplicationController
  
  before_filter :authenticate_user!, except: :show

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @rateable = @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    if @comment.save
      flash[:notice] = "Response successfully created."
      redirect_to post_path(@post)
    else
      flash[:error] = "Aack! Something went wrong."
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to post_path(@post)
    else
      flash[:error] = "You cannot delete another user's comments."
      redirect_to post_path(@post)
    end
  end

end
