require 'test_helper'

class HaveFieldsControllerTest < ActionController::TestCase
  setup do
    @have_field = have_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:have_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create have_field" do
    assert_difference('HaveField.count') do
      post :create, have_field: @have_field.attributes
    end

    assert_redirected_to have_field_path(assigns(:have_field))
  end

  test "should show have_field" do
    get :show, id: @have_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @have_field
    assert_response :success
  end

  test "should update have_field" do
    put :update, id: @have_field, have_field: @have_field.attributes
    assert_redirected_to have_field_path(assigns(:have_field))
  end

  test "should destroy have_field" do
    assert_difference('HaveField.count', -1) do
      delete :destroy, id: @have_field
    end

    assert_redirected_to have_fields_path
  end
end
