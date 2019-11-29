# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module SocioDemographicAuthorizationHandler
    # This is the engine that runs on the public interface of socio_demographic_authorization_handler.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SocioDemographicAuthorizationHandler

      routes do
        # Add engine routes here
        # resources :socio_demographic_authorization_handler
        # root to: "socio_demographic_authorization_handler#index"
      end

      initializer "decidim_socio_demographic_authorization_handler.assets" do |app|
        app.config.assets.precompile += %w[decidim_socio_demographic_authorization_handler_manifest.js decidim_socio_demographic_authorization_handler_manifest.css]
      end
    end
  end
end
