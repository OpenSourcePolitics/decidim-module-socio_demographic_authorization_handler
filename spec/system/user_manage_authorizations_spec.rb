# frozen_string_literal: true

require "spec_helper"

describe "User authorizations", type: :system do
  let!(:scope) { create_list(:scope, 3, organization: organization) }
  let!(:organization) do
    create(:organization,
           available_authorizations: ["socio_demographic_authorization_handler"])
  end

  let(:user) { create(:user) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim.root_path
    click_link user.name
    click_link "Authorizations"
  end

  it "displays the authorization item" do
    within ".tabs-content.vertical" do
      expect(page).to have_content("Socio Demographic Authorization")
    end
  end

  context "when accessing authorization" do
    before do
      visit "/authorizations"

      click_link "Socio Demographic Authorization"
    end

    it "displays authorization form" do
      expect(page).to have_content "Socio Demographic Authorization"

      within ".new_authorization_handler" do
        expect(page).to have_content("Scope")
        expect(page).to have_field("Gender")
        expect(page).to have_field("Age")
      end
    end

    it "allows user to fill form" do
      scope_pick select_data_picker(:authorization_handler_scope_id), organization.scopes.first
      select("Man", from: "Gender")
      select("16-25", from: "Age")
      click_button "Send"

      expect(page).to have_content("You've been successfully authorized")
    end
  end
end
