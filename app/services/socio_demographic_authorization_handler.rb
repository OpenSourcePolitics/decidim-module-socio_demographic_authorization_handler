# frozen_string_literal: true


# Allows to create a form for simple Socio Demographic authorization
  class SocioDemographicAuthorizationHandler < Decidim::AuthorizationHandler

    attribute :scope, String
    attribute :gender, String
    attribute :age, String

    SCOPES = Decidim::Scope.all.map { |scope| scope.code.downcase }
    GENDER = %w(man woman undefined).freeze
    AGE_SLICE = %w(16-25 26-45 46-65 65+).freeze

    validates :scope,
              inclusion: { in: SCOPES },
              presence: true

    validates :gender,
              inclusion: { in: GENDER },
              presence: true

    validates :age,
              inclusion: { in: AGE_SLICE },
              presence: true

    def metadata
      super.merge(scope: scope, gender: gender, age: age)
    end

  end
