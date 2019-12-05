# frozen_string_literal: true

Decidim::Verifications.register_workflow(:socio_demographic_authorization_handler) do |workflow|
  workflow.form = 'SocioDemographicAuthorizationHandler'

  # OPTIONAL - Add fields in BackOffice
  # workflow.options do |options|
  # options.attribute :scope, type: :array, required: false
  # options.attribute :gender, type: :string, required: false
  # options.attribute :age, type: :integer, required: false
  # end
end
