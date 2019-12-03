# frozen_string_literal: true

module Decidim
  module Models
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class SocioDemographicAuthorizationController < Devise::AuthorizationModalsController

      def authorizations
        super
        byebug
      end
    end
  end
end
