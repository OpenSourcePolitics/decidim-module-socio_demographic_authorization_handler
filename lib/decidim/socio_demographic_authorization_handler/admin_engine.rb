# frozen_string_literal: true

module Decidim
  module SocioDemographicAuthorizationHandler
    # This is the engine that runs on the public interface of `SocioDemographicAuthorizationHandler`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::SocioDemographicAuthorizationHandler::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :socio_demographic_authorization_handler do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "socio_demographic_authorization_handler#index"
      end

      def load_seed
        nil
      end
    end
  end
end
