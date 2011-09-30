require 'test_helper'

class BikeBrandsControllerTest < ActionController::TestCase
  setup do
    @bike_brand = bike_brands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bike_brands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike_brand" do
    assert_difference('BikeBrand.count') do
      post :create, bike_brand: @bike_brand.attributes
    end

    assert_redirected_to bike_brand_path(assigns(:bike_brand))
  end

  test "should show bike_brand" do
    get :show, id: @bike_brand.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike_brand.to_param
    assert_response :success
  end

  test "should update bike_brand" do
    put :update, id: @bike_brand.to_param, bike_brand: @bike_brand.attributes
    assert_redirected_to bike_brand_path(assigns(:bike_brand))
  end

  test "should destroy bike_brand" do
    assert_difference('BikeBrand.count', -1) do
      delete :destroy, id: @bike_brand.to_param
    end

    assert_redirected_to bike_brands_path
  end
end
