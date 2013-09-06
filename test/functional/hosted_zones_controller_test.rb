require 'test_helper'

class HostedZonesControllerTest < ActionController::TestCase
  setup do
    @hosted_zone = hosted_zones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosted_zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hosted_zone" do
    assert_difference('HostedZone.count') do
      post :create, hosted_zone: { name: @hosted_zone.name, zone_id: @hosted_zone.zone_id }
    end

    assert_redirected_to hosted_zone_path(assigns(:hosted_zone))
  end

  test "should show hosted_zone" do
    get :show, id: @hosted_zone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hosted_zone
    assert_response :success
  end

  test "should update hosted_zone" do
    put :update, id: @hosted_zone, hosted_zone: { name: @hosted_zone.name, zone_id: @hosted_zone.zone_id }
    assert_redirected_to hosted_zone_path(assigns(:hosted_zone))
  end

  test "should destroy hosted_zone" do
    assert_difference('HostedZone.count', -1) do
      delete :destroy, id: @hosted_zone
    end

    assert_redirected_to hosted_zones_path
  end
end
