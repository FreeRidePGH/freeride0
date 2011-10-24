require 'test_helper'

class BikeAssesmentsControllerTest < ActionController::TestCase
  setup do
    @bike_assesment = bike_assesments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bike_assesments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike_assesment" do
    assert_difference('BikeAssesment.count') do
      post :create, bike_assesment: @bike_assesment.attributes
    end

    assert_redirected_to bike_assesment_path(assigns(:bike_assesment))
  end

  test "should show bike_assesment" do
    get :show, id: @bike_assesment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike_assesment.to_param
    assert_response :success
  end

  test "should update bike_assesment" do
    put :update, id: @bike_assesment.to_param, bike_assesment: @bike_assesment.attributes
    assert_redirected_to bike_assesment_path(assigns(:bike_assesment))
  end

  test "should destroy bike_assesment" do
    assert_difference('BikeAssesment.count', -1) do
      delete :destroy, id: @bike_assesment.to_param
    end

    assert_redirected_to bike_assesments_path
  end
end
