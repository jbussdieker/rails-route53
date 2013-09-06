require 'test_helper'

class HealthChecksControllerTest < ActionController::TestCase
  setup do
    @health_check = health_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:health_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create health_check" do
    assert_difference('HealthCheck.count') do
      post :create, health_check: { fully_qualified_domain_name: @health_check.fully_qualified_domain_name, health_check_id: @health_check.health_check_id, ip_address: @health_check.ip_address, port: @health_check.port, resource_path: @health_check.resource_path, type: @health_check.type }
    end

    assert_redirected_to health_check_path(assigns(:health_check))
  end

  test "should show health_check" do
    get :show, id: @health_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @health_check
    assert_response :success
  end

  test "should update health_check" do
    put :update, id: @health_check, health_check: { fully_qualified_domain_name: @health_check.fully_qualified_domain_name, health_check_id: @health_check.health_check_id, ip_address: @health_check.ip_address, port: @health_check.port, resource_path: @health_check.resource_path, type: @health_check.type }
    assert_redirected_to health_check_path(assigns(:health_check))
  end

  test "should destroy health_check" do
    assert_difference('HealthCheck.count', -1) do
      delete :destroy, id: @health_check
    end

    assert_redirected_to health_checks_path
  end
end
