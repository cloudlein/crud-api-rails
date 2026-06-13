require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @author = authors(:one) # Need authors fixture
    @book = books(:one)
  end

  test "should get index" do
    get books_url, as: :json, headers: authenticated_header(@user)
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      assert_enqueued_with(job: NotifyNewBookJob) do
        post books_url, params: { title: "New Book", author_id: @author.id }, as: :json, headers: authenticated_header(@user)
      end
    end
    assert_response :created
  end
end
