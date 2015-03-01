class ApiCarsController < ApplicationController

  include EApiServer::Web::JSON::ServiceControllable

  protected
  
  def get_resource_params
    params.require(:api_car).permit(:name, :enrollment)
  end

  def get_order_params( required_params )
    required_params.permit( :id, :name )
  end

end
