require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test "that rating a post based on user_id and post_id works" do
    Rating.create user_id: users(:adam).id, post_id: posts(:one).id
    assert @rating.save
  end
end