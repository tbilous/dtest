module AcceptanceHelper
  def save_screenshot(name = nil)
    path = name || "screenshot-#{Time.now.utc.iso8601.delete('-:')}.png"
    page.save_screenshot path
    File.join(Capybara.save_path, path)
  end

  # Wait materialize-css animation completes
  def wait_animation
    sleep 0.8
  end

  def attach_hidden_files(locator, *files)
    with_hidden_fields do
      files.each do |path|
        find(locator).set path
      end
    end
  end

  def sign_in_as!(user, password = ('a' * 8))
    visit sign_in_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: password
    within '#new_session' do
      click_on t('users.new.sign_in')
    end
  end
end
