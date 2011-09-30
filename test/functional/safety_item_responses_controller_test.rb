require 'test_helper'

class SafetyItemResponsesControllerTest < ActionController::TestCase
  setup do
    @safety_item_response = safety_item_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:safety_item_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create safety_item_response" do
    assert_difference('SafetyItemResponse.count') do
      post :create, safety_item_response: @safety_item_response.attributes
    end

    assert_redirected_to safety_item_response_path(assigns(:safety_item_response))
  end

  test "should show safety_item_response" do
    get :show, id: @safety_item_response.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @safety_item_response.to_param
    assert_response :success
  end

  test "should update safety_item_response" do
    put :update, id: @safety_item_response.to_param, safety_item_response: @safety_item_response.attributes
    assert_redirected_to safety_item_response_path(assigns(:safety_item_response))
  end

  test "should destroy safety_item_response" do
    assert_difference('SafetyItemResponse.count', -1) do
      delete :destroy, id: @safety_item_response.to_param
    end

    assert_redirected_to safety_item_responses_path
  end
end
