require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get genres_url, as: :json, headers: authenticated_header(users(:one))
    assert_response :success
  end
end
