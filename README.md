#API Server Gem
This is a gem used for converting a any controller in a JSON REST API
You just need to include the module <b>EApiServer::Web::JSON::ServiceControllable</b> in your controller.

```ruby
class ApiCarController < ApplicationController

  include EApiServer::Web::JSON::ServiceControllable

end
```

This include will add the following actions to your controller:

<ul>
  <li>
    POST create - /{controller_name}
  </li>
  <li>
    DELETE destroy - /{controller_name}/1
  </li>
  <li>
    GET index - /{controller_name}
  </li>
  <li>
    GET show - /{controller_name}/1
  </li>
  <li>
    PATCH/PUT update - /{controller_name}/1
  </li>
</ul>

Only allow a trusted parameter "white list" through. If a single resource is loaded for #create or #update, then the controller for the resource must implement the method "#{resource_name}_params" to limit permitted parameters for the individual model.

Example:

```ruby
class ApiCarController < ApplicationController

  include EApiServer::Web::JSON::ServiceControllable
  
  protected
  
  def get_resource_params
    params.require(:api_car).permit(:id, :name, :enrollment, :brand_id)
  end

end
```

By default, the module will try to infer the following properties

<ul>
  <li> resource_class = The resource class based on the controller 
    <ul>
      <li> @return [Class] </li>
      <li> Default: Classified name for the controller based on the classified transformation of the string property <b>resource_name</b>. For ApiCarController, default will be ApiCar </li>
      <li> Override with the following method: <b>get_resource_class</b> </li>
    </ul>
  </li>
  <li> resource_name = The singular name for the resource class based on the controller 
    <ul>
      <li> @return [String] </li>
      <li> Default: Singularized name of the current controller. For ApiCarController, default will be api_car </li>
      <li> Override with the following method: <b>get_resource_name</b> </li>
    </ul>
  </li>
  <li> query_params = Allowed parameters for searching 
    <ul>
      <li> @return [Hash] </li>
      <li> Default: {} </li>
      <li> Override with the following method: <b>get_query_params</b> </li>
    </ul>
  </li>
  <li> page_params = Allowed parameters for pagination 
    <ul>
      <li> @return [Hash] </li>
      <li> Default: params.permit(:page, :page_size) </li>
      <li> Override with the following method: <b>get_page_params</b> </li>
    </ul>
  </li>
</ul>