require 'test_helper'

class CoauthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coauthor = coauthors(:one)
  end

  test "should get index" do
    get coauthors_url
    assert_response :success
  end

  test "should get new" do
    get new_coauthor_url
    assert_response :success
  end

  test "should create coauthor" do
    assert_difference('Coauthor.count') do
      post coauthors_url, params: { coauthor: { book_id: @coauthor.book_id, user_id: @coauthor.user_id } }
    end

    assert_redirected_to coauthor_url(Coauthor.last)
  end

  test "should show coauthor" do
    get coauthor_url(@coauthor)
    assert_response :success
  end

  test "should get edit" do
    get edit_coauthor_url(@coauthor)
    assert_response :success
  end

  test "should update coauthor" do
    patch coauthor_url(@coauthor), params: { coauthor: { book_id: @coauthor.book_id, user_id: @coauthor.user_id } }
    assert_redirected_to coauthor_url(@coauthor)
  end

  test "should destroy coauthor" do
    assert_difference('Coauthor.count', -1) do
      delete coauthor_url(@coauthor)
    end

    assert_redirected_to coauthors_url
  end
end
