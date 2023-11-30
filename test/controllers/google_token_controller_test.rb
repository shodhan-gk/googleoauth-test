require 'test_helper'

class GoogleTokenControllerTest < ActionController::TestCase
  test "should get token" do
    get :token
    assert_response :success
  end

end
