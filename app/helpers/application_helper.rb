module ApplicationHelper

  def flash_class (type)
    case type
    when :alert
      "alert-error"
    when :notice
      "alert-success"
    else
      ""
    end
  end

  def average_rating
    parent = parent_object
    @value = 0
    parent.ratings.each do |rating|
      @value += rating.value
    end
    @total = parent.ratings.size
    @value.to_f / @total.to_f
  end

  def parent_object
    if params.include?(:post_id)
      Comment.find_by_id(params[:id])
    else
      Post.find_by_id(params[:id])
    end
  end

  def current_user_rating
    @rating = current_user.ratings.find_by_rateable_id_and_rateable_type(params[:id], @rateable.class)
    @rating.value
  end

end
