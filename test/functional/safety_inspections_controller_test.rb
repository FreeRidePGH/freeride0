require 'test_helper'

class SafetyInspectionsControllerTest < ActionController::TestCase
  setup do
    @safety_inspection = safety_inspections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:safety_inspections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create safety_inspection" do
    assert_difference('SafetyInspection.count') do
      post :create, safety_inspection: @safety_inspection.attributes
    end

    assert_redirected_to safety_inspection_path(assigns(:safety_inspection))
  end

  test "should show safety_inspection" do
    get :show, id: @safety_inspection.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @safety_inspection.to_param
    assert_response :success
  end

  test "should update safety_inspection" do
    put :update, id: @safety_inspection.to_param, safety_inspection: @safety_inspection.attributes
    assert_redirected_to safety_inspection_path(assigns(:safety_inspection))
  end

  test "should destroy safety_inspection" do
    assert_difference('SafetyInspection.count', -1) do
      delete :destroy, id: @safety_inspection.to_param
    end

    assert_redirected_to safety_inspections_path
  end
end
