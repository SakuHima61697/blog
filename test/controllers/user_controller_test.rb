require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_create_url
    assert_response :success
  end

  test "should get login" do
    get user_login_url
    assert_response :success
  end

end
