require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

end
