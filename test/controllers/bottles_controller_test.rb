require 'test_helper'

class BottlesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bottles_new_url
    assert_response :success
  end

end
