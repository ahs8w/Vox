require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should have_many(:post_links)
  should have_many(:sub_posts)
  
  test "that a post requires a title" do
    post = Post.new
    post.title = ""
    assert !post.save
    assert !post.errors[:title].empty?
  end
  
  test "that a post requires content" do
    post = Post.new
    assert !post.save
    assert !post.errors[:content].empty?
  end
  
  test "that a post's content is at least 2 letters" do
    post = Post.new
    post.content = "h"
    assert !post.save
    assert !post.errors[:content].empty?
  end
  
  test "that a post has a user id" do
    post = Post.new
    post.content = "hello"
    assert !post.save
    assert !post.errors[:user_id].empty?
  end

  test "that a post requires a category" do
    post = Post.new
    post.category = ""
    assert !post.save
    assert !post.errors[:category].empty?
  end

  test "that a post requires a location" do
    post = Post.new
    post.location = ""
    assert !post.save
    assert !post.errors[:location].empty?
  end

  test "that no error is raised when trying to access a post's sub_post" do
    assert_nothing_raised do
      posts(:one).sub_posts
    end
  end

  test "that linking sub_posts to a post works" do
    posts(:one).sub_posts << posts(:three)
    posts(:one).sub_posts.reload
    assert posts(:one).sub_posts.include?(posts(:three))
  end
  
end
