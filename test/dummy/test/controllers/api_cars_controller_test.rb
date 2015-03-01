require 'test_helper'

class ApiCarsControllerTest < ActionController::TestCase

  setup do
    @api_car = api_cars(:one)
  end

  #Shared example for objects
  def assert_object
    assert_response :success
    assert_kind_of Hash, json_response
    assert_kind_of Integer, json_response["id"]
  end

  test "should order records" do
    get :index, format: :json, ordering: { id: "desc" }
    assert_response :success
    assert_kind_of Array, json_response
    assert_equal json_response.first["id"], ApiCar.order( id: :desc ).first.id    
  end

  test "should page records" do
    get :index, format: :json, pagination: { page: 2, page_size: 3 }, ordering: { name: :asc }
    assert_response :success
    assert_kind_of Array, json_response
    assert_equal json_response.size, 3
    assert_equal json_response.first["name"], "MyString 4"
  end

  test "should get index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:api_cars)
    assert_kind_of Array, json_response
  end

  test "should create api_car" do
    assert_difference('ApiCar.count') do
      post :create, format: :json, api_car: { enrollment: @api_car.enrollment, name: @api_car.name }
    end

    assert_equal response.status, 201
    assert_object
  end

  test "should show api_car" do
    get :show, format: :json, id: @api_car
    assert_object
  end

  test "should update api_car" do
    put :update, format: :json, id: @api_car, api_car: { enrollment: @api_car.enrollment, name: @api_car.name }

    assert_object
  end

  test "should destroy api_car" do
    assert_difference('ApiCar.count', -1) do
      delete :destroy, id: @api_car
    end

    assert_equal response.status, 204
  end

end
