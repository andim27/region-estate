require 'test_helper'

class RayonsAdminsControllerTest < ActionController::TestCase
  setup do
    @rayons_admin = rayons_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rayons_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rayons_admin" do
    assert_difference('RayonsAdmin.count') do
      post :create, rayons_admin: @rayons_admin.attributes
    end

    assert_redirected_to rayons_admin_path(assigns(:rayons_admin))
  end

  test "should show rayons_admin" do
    get :show, id: @rayons_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rayons_admin
    assert_response :success
  end

  test "should update rayons_admin" do
    put :update, id: @rayons_admin, rayons_admin: @rayons_admin.attributes
    assert_redirected_to rayons_admin_path(assigns(:rayons_admin))
  end

  test "should destroy rayons_admin" do
    assert_difference('RayonsAdmin.count', -1) do
      delete :destroy, id: @rayons_admin
    end

    assert_redirected_to rayons_admins_path
  end
end
