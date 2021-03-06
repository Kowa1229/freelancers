require 'test_helper'

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get public_home_url
    assert_response :success
  end

  test "should get help" do
    get public_help_url
    assert_response :success
  end

  test "should get feedback" do
    get public_feedback_url
    assert_response :success
  end

end
