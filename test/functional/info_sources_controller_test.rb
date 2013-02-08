require 'test_helper'

class InfoSourcesControllerTest < ActionController::TestCase
  setup do
    @info_source = info_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:info_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create info_source" do
    assert_difference('InfoSource.count') do
      post :create, info_source: @info_source.attributes
    end

    assert_redirected_to info_source_path(assigns(:info_source))
  end

  test "should show info_source" do
    get :show, id: @info_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @info_source
    assert_response :success
  end

  test "should update info_source" do
    put :update, id: @info_source, info_source: @info_source.attributes
    assert_redirected_to info_source_path(assigns(:info_source))
  end

  test "should destroy info_source" do
    assert_difference('InfoSource.count', -1) do
      delete :destroy, id: @info_source
    end

    assert_redirected_to info_sources_path
  end
end
