module EApiServer


	class ERailtie < Rails::Railtie

    config.before_configuration do
			require 'kaminari'
			require 'responders'
    end

	end

end
