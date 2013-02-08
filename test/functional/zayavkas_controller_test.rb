require 'test_helper'

class ZayavkasControllerTest < ActionController::TestCase
  setup do
    @zayavka = zayavkas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zayavkas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zayavka" do
    assert_difference('Zayavka.count') do
      post :create, zayavka: @zayavka.attributes
    end

    assert_redirected_to zayavka_path(assigns(:zayavka))
  end

  test "should show zayavka" do
    get :show, id: @zayavka
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @zayavka
    assert_response :success
  end

  test "should update zayavka" do
    put :update, id: @zayavka, zayavka: @zayavka.attributes
    assert_redirected_to zayavka_path(assigns(:zayavka))
  end

  test "should destroy zayavka" do
    assert_difference('Zayavka.count', -1) do
      delete :destroy, id: @zayavka
    end

    assert_redirected_to zayavkas_path
  end
end
