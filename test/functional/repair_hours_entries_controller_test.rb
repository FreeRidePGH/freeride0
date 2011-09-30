require 'test_helper'

class RepairHoursEntriesControllerTest < ActionController::TestCase
  setup do
    @repair_hours_entry = repair_hours_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repair_hours_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repair_hours_entry" do
    assert_difference('RepairHoursEntry.count') do
      post :create, repair_hours_entry: @repair_hours_entry.attributes
    end

    assert_redirected_to repair_hours_entry_path(assigns(:repair_hours_entry))
  end

  test "should show repair_hours_entry" do
    get :show, id: @repair_hours_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repair_hours_entry.to_param
    assert_response :success
  end

  test "should update repair_hours_entry" do
    put :update, id: @repair_hours_entry.to_param, repair_hours_entry: @repair_hours_entry.attributes
    assert_redirected_to repair_hours_entry_path(assigns(:repair_hours_entry))
  end

  test "should destroy repair_hours_entry" do
    assert_difference('RepairHoursEntry.count', -1) do
      delete :destroy, id: @repair_hours_entry.to_param
    end

    assert_redirected_to repair_hours_entries_path
  end
end
