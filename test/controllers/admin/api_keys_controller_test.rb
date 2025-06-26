require "test_helper"

class Admin::ApiKeysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_api_keys_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_api_keys_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_api_keys_destroy_url
    assert_response :success
  end
end
