require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:post)

## Validation Tests ##  
  
  test "that a comment requires a title" do
    comment = Comment.new
    comment.title = ""
    assert !comment.save
    assert !comment.errors[:title].empty?
  end
  
  test "that a comment requires content" do
    comment = Comment.new
    assert !comment.save
    assert !comment.errors[:content].empty?
  end
  
  test "that a comment's content is at least 2 letters" do
    comment = Comment.new
    comment.content = "h"
    assert !comment.save
    assert !comment.errors[:content].empty?
  end
  
  test "that a comment has a user id" do
    comment = Comment.new
    comment.content = "hello"
    assert !comment.save
    assert !comment.errors[:user_id].empty?
  end

  test "that a comment requires a category" do
    comment = Comment.new
    comment.category = ""
    assert !comment.save
    assert !comment.errors[:category].empty?
  end

  test "that a comment requires a location" do
    comment = Comment.new
    comment.location = ""
    assert !comment.save
    assert !comment.errors[:location].empty?
  end

## Crud tests ##

  test "should create a new comment" do
    comment = Comment.new
    comment.user_id = users(:adam).id
    comment.post_id = posts(:one).id
    comment.title = "hello"
    comment.category = "news"
    comment.location = "22902"
    comment.content = "my new comment"

    assert comment.save
  end

  test "should find comment" do 
    comment_id = comments(:one).id
    assert_nothing_raised { Comment.find(comment_id) }
  end
  
  test "should destroy comment if primary article is destroyed" do
    post = posts(:one)
    comment = post.comments.first
    post.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Comment.find(comment.id) }
  end

end