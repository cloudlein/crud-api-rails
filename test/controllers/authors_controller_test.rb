require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get authors_url, as: :json, headers: authenticated_header(users(:one))
    assert_response :success
  end
end
