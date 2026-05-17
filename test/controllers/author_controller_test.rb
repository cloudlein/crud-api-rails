require "test_helper"

class AuthorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get author_index_url
    assert_response :success
  end
end
