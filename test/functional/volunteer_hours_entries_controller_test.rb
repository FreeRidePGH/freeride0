require 'test_helper'

class VolunteerHoursEntriesControllerTest < ActionController::TestCase
  setup do
    @volunteer_hours_entry = volunteer_hours_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:volunteer_hours_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create volunteer_hours_entry" do
    assert_difference('VolunteerHoursEntry.count') do
      post :create, volunteer_hours_entry: @volunteer_hours_entry.attributes
    end

    assert_redirected_to volunteer_hours_entry_path(assigns(:volunteer_hours_entry))
  end

  test "should show volunteer_hours_entry" do
    get :show, id: @volunteer_hours_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @volunteer_hours_entry.to_param
    assert_response :success
  end

  test "should update volunteer_hours_entry" do
    put :update, id: @volunteer_hours_entry.to_param, volunteer_hours_entry: @volunteer_hours_entry.attributes
    assert_redirected_to volunteer_hours_entry_path(assigns(:volunteer_hours_entry))
  end

  test "should destroy volunteer_hours_entry" do
    assert_difference('VolunteerHoursEntry.count', -1) do
      delete :destroy, id: @volunteer_hours_entry.to_param
    end

    assert_redirected_to volunteer_hours_entries_path
  end
end
