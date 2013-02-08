require 'test_helper'

class DopParamsControllerTest < ActionController::TestCase
  setup do
    @dop_param = dop_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dop_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dop_param" do
    assert_difference('DopParam.count') do
      post :create, dop_param: @dop_param.attributes
    end

    assert_redirected_to dop_param_path(assigns(:dop_param))
  end

  test "should show dop_param" do
    get :show, id: @dop_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dop_param
    assert_response :success
  end

  test "should update dop_param" do
    put :update, id: @dop_param, dop_param: @dop_param.attributes
    assert_redirected_to dop_param_path(assigns(:dop_param))
  end

  test "should destroy dop_param" do
    assert_difference('DopParam.count', -1) do
      delete :destroy, id: @dop_param
    end

    assert_redirected_to dop_params_path
  end
end
