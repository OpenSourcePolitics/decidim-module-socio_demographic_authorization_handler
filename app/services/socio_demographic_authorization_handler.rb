# frozen_string_literal: true

# An example authorization handler used so that users can be verified against
# third party systems.
#
# You should probably rename this class and file to match your needs.
#
# If you need a custom form to be rendered, you can create a file matching the
# class name named "_form".
#
# Example:
#
#   A handler named Decidim::CensusHandler would look for its partial in:
#   decidim/census/form
#
# When testing your authorization handler, add this line to be sure it has a
# valid public api:
#
#   it_behaves_like "an authorization handler"
#
# See Decidim::AuthorizationHandler for more documentation.
class SocioDemographicAuthorizationHandler < Decidim::AuthorizationHandler

  # Define the attributes you need for this authorization handler. Attributes
  # are defined using Virtus.
  #
  attribute :scope, String
  attribute :gender, String
  attribute :age, Integer


  GENDER = %w(man woman undefined).freeze
  SCOPES = Decidim::Scope.all.map { |scope| scope.code.downcase }


  # You can (and should) also define validations on each attribute:
  validates :scope,
            inclusion: {in: SCOPES},
            presence: true

  validates :gender,
            inclusion: {in: GENDER},
            presence: true

  validates :age, presence: true

  def metadata
    {
      "scope" => scope,
      "gender" => gender,
      "age" => age
    }
  end

  def verification_metadata
    {
      "scope" => scope,
      "gender" => gender,
      "age" => age
    }
  end
end
