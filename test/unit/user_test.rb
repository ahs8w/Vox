require 'test_helper'

# To run a test in the console:
# Type:   ruby -Itest test/unit/user_test.rb

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end 
  
  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end 
  
  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end 
  
  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:adam).profile_name
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a profile name without spaces" do
    user = User.new
    user.profile_name = "My profile with spaces"
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end
  
  test "a user should have a correctly formatted profile name" do
    user = User.new(first_name: 'Adam', last_name: 'Schiller', email: 'ahs8w2@virginia.edu')
    user.password = user.password_confirmation = 'asdfghjk'
    
    user.profile_name = 'ahs8w2'
    assert user.valid?
  end
  
  
end
