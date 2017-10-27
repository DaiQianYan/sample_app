require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # get sessions_new_url
    # Updating the Sessions controller test to use the login route.
    get login_path
    assert_response :success
  end

end
