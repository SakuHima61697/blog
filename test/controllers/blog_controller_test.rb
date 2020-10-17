require 'test_helper'

class BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_index_url
    assert_response :success
  end

  test "should get create" do
    get blog_create_url
    assert_response :success
  end

  test "should get show" do
    get blog_show_url
    assert_response :success
  end

  test "should get update" do
    get blog_update_url
    assert_response :success
  end

  test "should get delete" do
    get blog_delete_url
    assert_response :success
  end

  test "should get login" do
    get blog_login_url
    assert_response :success
  end

end
