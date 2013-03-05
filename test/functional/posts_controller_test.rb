require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end  
  
  test "should render new page when logged in" do
    sign_in users(:adam)
    get :new
    assert_response :success
  end

  test "should be logged in to create a post" do
    post :create, post: { content: "Here I Is", title: "hello" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end  
  
  test "should create a post when logged in" do
    sign_in users(:adam)
    assert_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should create a post for the current user when logged in" do
    sign_in users(:adam)
    assert_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title, user_id: users(:jason).id }
    end

    assert_redirected_to post_path(assigns(:post))
    assert_equal assigns(:post).user_id, users(:adam).id
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @post
    assert_response :redirect
    assert_redirected_to new_user_session_path    
  end  
  
  test "should get edit when logged in" do
    sign_in users(:adam)
    get :edit, id: @post
    assert_response :success
  end

  test "should redirect update post when not logged in" do
    put :update, id: @post, post: { content: @post.content, title: @post.title }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should update post when logged in" do
    sign_in users(:adam)
    put :update, id: @post, post: { content: @post.content, title: @post.title }
    assert_redirected_to post_path(assigns(:post))
  end

test "should update post for the current user when logged in" do
    sign_in users(:adam)
    put :update, id: @post, post: { content: @post.content, user_id: users(:jason).id }
    assert_redirected_to post_path(assigns(:post))
    assert_equal assigns(:post).user_id, users(:adam).id 
  end

 test "should not update the post if nothing has changed" do
    sign_in users(:adam)
    put :update, id: @post
    assert_redirected_to post_path(assigns(:post))
    assert_equal assigns(:post).user_id, users(:adam).id
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
