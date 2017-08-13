require 'test_helper'

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get providers_new_url
    assert_response :success
  end

  test "should get create" do
    get providers_create_url
    assert_response :success
  end

  test "should get failure" do
    get providers_failure_url
    assert_response :success
  end

end
