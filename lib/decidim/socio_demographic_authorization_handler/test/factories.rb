# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :socio_demographic_authorization_handler_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :socio_demographic_authorization_handler).i18n_name }
    manifest_name :socio_demographic_authorization_handler
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
