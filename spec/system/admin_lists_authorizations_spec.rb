# frozen_string_literal: true

require "spec_helper"

describe "Admin lists authorizations", type: :system do
  let!(:organization) do
    create(:organization, available_authorizations: ["socio_demographic_authorization_handler"])
  end

  let(:admin) { create(:admin) }

  before do
    switch_to_host(organization.host)
    login_as admin, scope: :admin
    visit decidim_system.root_path
    click_link "Organizations"
    click_link organization.name
    click_link "Edit"
  end

  it "allows the system admin to list all available authorization methods" do
    within ".edit_organization" do
      expect(page).to have_content("Socio demographic authorization")
    end
  end
end
