class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @rateable = parent_object
    if current_user.id == @rateable.user_id
      redirect_to parent_url(@rateable), :alert => "You cannot rate your own post."
    else
    @rating = @rateable.ratings.build(params[:rating])
    @rating.user_id = current_user.id
      if @rating.save
        flash[:notice] = "Rating saved."
        redirect_to parent_url(@rateable)
      else
        flash[:error] = "Aack! Something went wrong."
        redirect_to parent_url(@rateable)
      end
    end
  end

private
# find the rateable parent: returns e.g. Post.find(:id)
  def parent_object
    case
      when params[:post_id]then Post.find_by_id(params[:post_id])
      when params[:comment_id]then Comment.find_by_id(params[:comment_id])
    end
  end

  def parent_url(parent)
    case
      when params[:post_id]then post_url(parent)
      when params[:comment_id]then comment_url(parent)
    end
  end
  
end
