class ProfilesController < ApplicationController
  def show
    @user = User.find_by_profile_name(params[:id])
    if @user
    	@posts = @user.posts.all
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

private
  def user_rating
    @user = User.find_by_profile_name(params[:id])
    @value = 0
    @posts = @user.posts.all
    @comments = @user.comments.all
    @posts.each do |post|
      if !post.ratings.empty?
        @value += post.average_rating
      end
    end
    @comments.each do |comment|
      if !comment.ratings.empty?
        @value += comment.average_rating
      end
    end
    @total = Rating.find_by_rateable_id(@user.id)
    @value / @total.size
  end
end
