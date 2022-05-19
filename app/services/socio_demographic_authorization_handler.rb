# frozen_string_literal: true

# Allows to create a form for simple Socio Demographic authorization
class SocioDemographicAuthorizationHandler < Decidim::AuthorizationHandler
  attribute :scope_id, Integer
  attribute :gender, String
  attribute :age, String

  GENDER = %w(woman man undefined).freeze
  AGE_SLICE = %w(16-25 26-45 46-65 65+).freeze

  validates :scope_id,
            format: { with: /\A\d+\z/, message: I18n.t("errors.messages.integer_only"), if: proc { |x| !x.scope_id.nil? && validate_scope } },
            presence: false

  validates :gender,
            inclusion: { in: GENDER, if: proc { |x| x.gender.present? } },
            presence: false

  validates :age,
            inclusion: { in: AGE_SLICE, if: proc { |x| x.age.present? } },
            presence: false

  def metadata
    super.merge(scope_id: scope_id, gender: gender, age: age)
  end

  private

  def validate_scope
    errors.add(:scope_id, :invalid) if Decidim::Scope.where(id: scope_id).empty?
  end
end
