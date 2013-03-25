require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:rateable)

  test "that a rating requires a value, user_id, and rateable_id" do
    rating = Rating.new
    assert !rating.valid?
    assert rating.errors[:value].any?
    assert rating.errors[:user_id].any?
    assert rating.errors[:rateable_id].any?
    assert !rating.save
  end


  test "should create a new rating" do
    rating = Rating.new
    rating.rateable_id = comments(:one).id
    rating.user_id = users(:jason).id
    rating.value = 3

    assert rating.save
  end

  test "should find a rating" do
    rating_id = ratings(:one).id
    assert_nothing_raised { Rating.find(rating_id) }
  end

  test "should destroy rating if rateable is destroyed" do
    comment = comments(:one)
    rating = ratings(:two)
    comment.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Rating.find(rating.id) }
  end


end