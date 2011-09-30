require 'test_helper'

class BikeModelsControllerTest < ActionController::TestCase
  setup do
    @bike_model = bike_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bike_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike_model" do
    assert_difference('BikeModel.count') do
      post :create, bike_model: @bike_model.attributes
    end

    assert_redirected_to bike_model_path(assigns(:bike_model))
  end

  test "should show bike_model" do
    get :show, id: @bike_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike_model.to_param
    assert_response :success
  end

  test "should update bike_model" do
    put :update, id: @bike_model.to_param, bike_model: @bike_model.attributes
    assert_redirected_to bike_model_path(assigns(:bike_model))
  end

  test "should destroy bike_model" do
    assert_difference('BikeModel.count', -1) do
      delete :destroy, id: @bike_model.to_param
    end

    assert_redirected_to bike_models_path
  end
end
