class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @rateable = rateable_object
    if current_user.id == @rateable.user_id
      redirect_to parent_url(@rateable), :alert => "You cannot rate your own post."
    else
    @rating = @rateable.ratings.build(params[:rating])
    @rating.user_id = current_user.id
      if @rating.save
        respond_to do |format|
          format.html { redirect_to parent_url(@rateable), :notice => "Rating saved." }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to parent_url(@rateable), :notice => "Aack! Something went wrong." }
          format.js
        end
      end
    end
  end

private
# find the rateable parent: returns e.g. Post.find(:id)
  def rateable_object
    case
      when params[:post_id] then Post.find_by_id(params[:post_id])
      when params[:comment_id] then Comment.find_by_id(params[:comment_id])
    end
  end

  def parent_url(parent)
    case
      when params[:post_id]then post_path(parent)
      when params[:comment_id]then post_comment_path(parent.post_id, parent)
    end
  end
  
end
