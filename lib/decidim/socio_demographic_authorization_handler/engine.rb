# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module SocioDemographicAuthorizationHandler
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SocioDemographicAuthorizationHandler

      initializer "decidim.extends" do
        require "decidim/extends/controllers/confirmations_controller_extend"
      end
    end
  end
end
