require 'acceptance_helper'

feature 'user can login', %q{
  User can to register
  User can to Sign in
} do

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  context 'as user' do
    scenario 'register' do
      visit new_user_registration_path

      fill_in 'user_email', with: 'test@ftrs.com'
      fill_in 'user_password', with: 'foobar'
      fill_in 'user_password_confirmation', with: 'foobar'
      within '#registration_new' do
        click_on t('active_admin.devise.sign_up.submit')
      end
      expect(current_path).to eq user_path(User.last.id)
    end

    scenario 'Sign In' do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      within '#session_new' do
        click_on t('active_admin.devise.login.submit')
      end

      expect(current_path).to eq user_path(user.id)
      expect(page).to have_link t('active_admin.logout')
      expect(page).to_not have_link t('active_admin.devise.links.sign_up')
    end
  end

  context 'as admin' do
    scenario 'Sign In' do
      visit new_user_session_path

      fill_in 'user_email', with: admin.email
      fill_in 'user_password', with: admin.password
      within '#session_new' do
        click_on t('active_admin.devise.login.submit')
      end

      expect(current_path).to eq admin_root_path
    end
  end
end
