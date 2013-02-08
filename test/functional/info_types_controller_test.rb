require 'test_helper'

class InfoTypesControllerTest < ActionController::TestCase
  setup do
    @info_type = info_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:info_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create info_type" do
    assert_difference('InfoType.count') do
      post :create, info_type: @info_type.attributes
    end

    assert_redirected_to info_type_path(assigns(:info_type))
  end

  test "should show info_type" do
    get :show, id: @info_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @info_type
    assert_response :success
  end

  test "should update info_type" do
    put :update, id: @info_type, info_type: @info_type.attributes
    assert_redirected_to info_type_path(assigns(:info_type))
  end

  test "should destroy info_type" do
    assert_difference('InfoType.count', -1) do
      delete :destroy, id: @info_type
    end

    assert_redirected_to info_types_path
  end
end
