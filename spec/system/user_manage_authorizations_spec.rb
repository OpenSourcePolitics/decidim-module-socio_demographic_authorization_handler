# frozen_string_literal: true

require 'spec_helper'

describe 'User authorizations', type: :system do
  let!(:organization) do
    create(:organization,
           available_authorizations: ['socio_demographic_authorization_handler']
          )
  end

  let(:user) { create(:user) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim.root_path
    click_link user.name
    click_link 'Authorizations'
  end

  it 'should display the authorization item' do
    within '.tabs-content.vertical' do
      expect(page).to have_content('Socio Demographic Authorization')
    end
  end

  context 'when accessing authorization' do
    before do
      visit '/authorizations'

      click_link 'Socio Demographic Authorization'
    end

    it 'should display authorization form' do
      expect(page).to have_content 'Socio Demographic Authorization'

      within '.new_authorization_handler' do
        expect(page).to have_field('authorization_handler_scope')
        expect(page).to have_field('authorization_handler_gender')
        expect(page).to have_field('authorization_handler_age')
        find('*[type=submit]')
      end

    end

  end
end
