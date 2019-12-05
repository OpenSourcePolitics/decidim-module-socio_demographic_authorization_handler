# frozen_string_literal: true

require 'spec_helper'

describe 'Authorizations', type: :system, with_authorization_workflows: ['socio_demographic_authorization_handler'] do
  let(:organization) { create :organization, available_authorizations: authorizations }
  let!(:scopes) { create_list(:scope, 9, organization: organization) }
  let(:user) { create(:user, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
  end

  context 'when a new user' do
    context 'when one authorization has been configured' do
      let(:authorizations) { ['socio_demographic_authorization_handler'] }

      before do
        visit decidim.root_path
        find('.sign-in-link').click

        within 'form.new_user' do
          fill_in :user_email, with: user.email
          fill_in :user_password, with: 'password1234'
          find('*[type=submit]').click
        end
      end

      it 'allows the user to skip it' do
        click_link 'start exploring'
        expect(page).to have_current_path decidim.account_path
        expect(page).to have_content('Participant settings')
      end
    end

    context 'when multiple authorizations have been configured', with_authorization_workflows: %w[socio_demographic_authorization_handler dummy_authorization_handler] do
      let(:authorizations) { %w[socio_demographic_authorization_handler dummy_authorization_handler] }

      before do
        visit decidim.root_path
        find('.sign-in-link').click

        within 'form.new_user' do
          fill_in :user_email, with: user.email
          fill_in :user_password, with: 'password1234'
          find('*[type=submit]').click
        end
      end

      it 'allows the user to choose which one to authorize against to' do
        expect(page).to have_css('a.button.expanded', count: 2)
      end
    end
  end

  context 'when existing user from her account' do
    before do
      login_as user, scope: :user
      visit decidim.root_path
    end

    context 'when the user has already been authorized' do
      let(:authorizations) { ['socio_demographic_authorization_handler'] }

      let!(:authorization) do
        create(:authorization, name: 'socio_demographic_authorization_handler', user: user)
      end

      it 'shows the authorization at their account' do
        within_user_menu do
          click_link 'My account'
        end

        click_link 'Authorizations'

        within '.authorizations-list' do
          expect(page).to have_content('Socio Demographic Authorization')
        end
      end

      context 'when the authorization has not expired yet' do
        let!(:authorization) do
          create(:authorization, name: 'socio_demographic_authorization_handler', user: user, granted_at: 2.seconds.ago)
        end

        it "can't be renewed yet" do
          within_user_menu do
            click_link 'My account'
          end

          click_link 'Authorizations'

          within '.authorizations-list' do
            expect(page).to have_no_link('Socio Demographic Authorization')
            expect(page).to have_content(I18n.localize(authorization.granted_at, format: :long))
          end
        end
      end

      context 'when the authorization has expired' do
        let!(:authorization) do
          create(:authorization, name: 'socio_demographic_authorization_handler', user: user, granted_at: 2.months.ago)
        end

        it 'can be renewed' do
          within_user_menu do
            click_link 'My account'
          end

          click_link 'Authorizations'

          within '.authorizations-list' do
            expect(page).to have_link('Socio Demographic Authorization')
            click_link 'Socio Demographic Authorization'
          end

          fill_in :scope, with: organization.scopes
          click_button 'Send'

          expect(page).to have_content("You've been successfully authorized")
        end
      end
    end

    context 'when no authorizations are configured', with_authorization_handlers: [] do
      let(:authorizations) { [] }

      it "doesn't list authorizations" do
        click_link user.name
        expect(page).to have_no_content('Authorizations')
      end
    end
  end
end
