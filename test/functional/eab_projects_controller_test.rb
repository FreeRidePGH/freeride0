require 'test_helper'

class EabProjectsControllerTest < ActionController::TestCase
  setup do
    @eab_project = eab_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eab_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eab_project" do
    assert_difference('EabProject.count') do
      post :create, eab_project: @eab_project.attributes
    end

    assert_redirected_to eab_project_path(assigns(:eab_project))
  end

  test "should show eab_project" do
    get :show, id: @eab_project.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eab_project.to_param
    assert_response :success
  end

  test "should update eab_project" do
    put :update, id: @eab_project.to_param, eab_project: @eab_project.attributes
    assert_redirected_to eab_project_path(assigns(:eab_project))
  end

  test "should destroy eab_project" do
    assert_difference('EabProject.count', -1) do
      delete :destroy, id: @eab_project.to_param
    end

    assert_redirected_to eab_projects_path
  end
end
