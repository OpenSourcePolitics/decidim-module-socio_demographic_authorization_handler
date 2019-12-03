# frozen_string_literal: true

require "active_support/concern"

module OfficializationsControllerExtend
  extend ActiveSupport::Concern

  def unique_id(user)
    authorizations.find_by(user: user).try(:unique_id)
  end

  def authorizations
    @authorizations ||= Decidim::Verifications::Authorizations.new(organization: current_organization, name: "socio_demographic_authorization_handler", granted: true)
                                                              .query
                                                              .where("verification_metadata->'rejected' IS NULL")
  end
end
