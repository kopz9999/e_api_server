module EApiServer

  module Web

    module JSON

      module ServiceControllable

        extend ActiveSupport::Concern

          included do

          #Avoid protect from forgery
          protect_from_forgery with: :null_session

          #Base initialization
          before_action :set_resource, only: [:destroy, :show, :update]

          #Specify it is a JSON API
          respond_to :json

          #Public methods allowed to be used as routes
          public

          # POST /api/{plural_resource_name}
          # TODO: Check
          def create
          	set_resource(resource_class.new(resource_params))

          	if get_resource.save
              show_resource status: :created
          	else
          		render json: { errors: get_resource.errors }, status: :unprocessable_entity
          	end
          end

          # DELETE /api/{plural_resource_name}/1
          def destroy
          	get_resource.destroy
          	head :no_content
          end

          # GET /api/{plural_resource_name}
          def index
          	plural_resource_name = "@#{resource_name.pluralize}"
          	resources = resource_class.where(query_params).page(page_params[:page]).per(page_params[:page_size]).order( order_params )

          	instance_variable_set(plural_resource_name, resources)

          	respond_with instance_variable_get(plural_resource_name)
          end

          # GET /api/{plural_resource_name}/1
          def show
            unless get_resource.nil?
              respond_with get_resource
            else
              head :no_content
            end
          end

          # PATCH/PUT /api/{plural_resource_name}/1
          def update
            if get_resource.update(resource_params)
              show_resource status: :ok
            else
              render json: { errors: get_resource.errors }, status: :unprocessable_entity
            end
          end	

          #Private methods to be used by Controller
          private

          # Returns the resource from the created instance variable
          # @return [Object]
          def get_resource
            instance_variable_get("@#{resource_name}")
          end

          # Returns the allowed parameters for searching
          # Override this method in each API controller
          # to permit additional parameters to search on
          # @return [Hash]
          def query_params
            get_query_params
          end

          # Returns the allowed parameters for pagination
          # @return [Hash]
          def page_params            
            params.has_key?(:pagination) ? get_page_params( params.require(:pagination) ) : {}
          end

          # Returns the allowed parameters for ordering
          # @return [Hash]
          def order_params
            params.has_key?(:ordering) ? get_order_params( params.require(:ordering) ) : {}
          end

          # The resource class based on the controller
          # @return [Class]
          def resource_class
          	@resource_class ||= get_resource_class
          end

          # The singular name for the resource class based on the controller
          # @return [String]
          def resource_name
            @resource_name ||= get_resource_name
          end

          # Only allow a trusted parameter "white list" through.
          # If a single resource is loaded for #create or #update,
          # then the controller for the resource must implement
          # the method "#{resource_name}_params" to limit permitted
          # parameters for the individual model.
          def resource_params
            @resource_params ||= get_resource_params
          end

          # Use callbacks to share common setup or constraints between actions.
          def set_resource(resource = nil)
            resource ||= resource_class.find_by_id(params[:id])
            instance_variable_set("@#{resource_name}", resource)
          end

          #Methods to be overriden 
          protected

          # Optional override if you prefer to use a template, render a json or whatever you want
          # @return [Action], [Template]
          def show_resource( opts = {} )
            if template_exists? (:show)
              render :show
            else
              render opts.merge( json: get_resource )
            end
          end

          # Override with the parameters you want
          # @return [Hash]
          def get_resource_params
          	raise NotImplementedError
          end

          # Override with model class
          # @return [Class]
          def get_resource_class
          	resource_name.classify.constantize
          end

          # Override to get name for instance variables
          # @return [String]
          def get_resource_name
          	self.controller_name.singularize
          end

          # Override to set query parameters
          # @return [Hash]
          def get_query_params
            {}
          end

          # Override to set query parameters
          # @return [Hash]
          def get_order_params( required_params )
            {}
          end

          # Override to set page parameters
          # @return [Hash]
          def get_page_params( required_params )
            required_params.permit( :page, :page_size )
          end

        end	

      end

    end

  end

end
