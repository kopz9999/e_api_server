#API Server Gem
This is a gem used for converting a any controller in a JSON REST API. If you have a Rails application as a client, it is recommended to use https://github.com/kopz9999/e_api_client to consume resources
<br/>
You just need to include the module <b>EApiServer::Web::JSON::ServiceControllable</b> in your controller.

```ruby
class ApiCarsController < ApplicationController

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

Only allow a trusted parameter "white list" through. If a single resource is loaded for <b> #create or #update</b>, then the controller for the resource must implement the method "#{resource_name}_params" to limit permitted parameters for the individual model.
<br/>
Example:

```ruby
class ApiCarsController < ApplicationController

  include EApiServer::Web::JSON::ServiceControllable
  
  protected
  
  def get_resource_params
    params.require(:api_car).permit(:id, :name, :enrollment)
  end

end
```

By default, the module will try to infer the following properties

<ul>
  <li> resource_class = The resource class based on the controller 
    <ul>
      <li> @return [Class] </li>
      <li> Default: Classified name for the controller based on the classified transformation of the string property <b>resource_name</b>. For ApiCarsController, default will be ApiCar </li>
      <li> Override with the following method: <b>get_resource_class</b> </li>
    </ul>
  </li>
  <li> resource_name = The singular name for the resource class based on the controller 
    <ul>
      <li> @return [String] </li>
      <li> Default: Singularized name of the current controller. For ApiCarsController, default will be api_car </li>
      <li> Override with the following method: <b>get_resource_name</b> </li>
    </ul>
  </li>
  <li> query_params = Allowed parameters for searching on <b>index action</b>. Use your own blacklists if not using strong params
    <ul>
      <li> @return [Hash] </li>
      <li> Default: {} </li>
      <li> Override with the following method: <b>get_query_params</b> </li>
      <li> Request Examples:
        <ul>
          <li>{ id: 32 }</li>
          <li>{ name: "Nissan Altima" } </li>
        </ul>
      </li>
      <li> Permit Params Examples:
        <ul>
          <li>params.permit(:name)</li>
        </ul>
      </li>
    </ul>
  </li>
  <li> page_params = Allowed parameters for pagination on <b>index action</b>
    <ul>
      <li> @return [Hash] </li>
      <li> Default: params.require(:pagination).permit( :page, :page_size ) </li>
      <li> Override with the following method: <b>get_page_params( required_params )</b>. Here required_params arg is params.require(:pagination) </li>
      <li> Request Examples:
        <ul>
          <li>{ pagination: { page: "1", page_size: "3" } }</li>
        </ul>
      </li>
    </ul>
  </li>
  <li> order_params = Allowed parameters for ordering on <b>index action</b>. Use your own blacklists if not using strong params
    <ul>
      <li> @return [Hash] </li>
      <li> Default: {} </li>
      <li> Override with the following method: <b>get_order_params( required_params )</b>. Here required_params arg is params.require(:ordering) </li>
      <li> Request Examples:
        <ul>
          <li> { ordering: { name: "asc", enrollment: "desc" } } </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>

If you are processing too many queries in the index, it is recommended that you change it to POST index in the routes.
<br/>
Other methods you may want to override are:

```ruby
# Override with your own implementation if you want to change it for a JBuilder template
# @return [Action]
def success_show
  render json: get_resource_params
end
```

If you still have doubts about how to query the index, please check the controller test in /test/dummy/test/controllers/api_cars_controller_test.rb

<br/>
For Rails >= 4.2 please add the responders gem on your gemfile:

```ruby
gem 'responders', '~> 2.0' 
```

When you test your API, make sure you request it with the correct format. Assumming you are running your API on port 3000, for ApiCarsController#index, you must request: http://localhost:3000/api_cars.json
<br/>
Remember, the suffix <b>.json</b> is the format of the request
<br/>
<br/>
#Copyright 2015 kopz9999@gmail.com

#License

Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with this
work for additional information regarding copyright ownership.  The ASF
licenses this file to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
License for the specific language governing permissions and limitations under
the License.
