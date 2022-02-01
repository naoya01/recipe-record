require 'test_helper'

class UsageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get usage_index_url
    assert_response :success
  end

end
