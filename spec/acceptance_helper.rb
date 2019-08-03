require 'rails_helper'
require 'capybara/webkit'
require 'selenium/webdriver'

RSpec.configure do |config|
  include ActionView::RecordIdentifier
  config.include AcceptanceHelper, type: :feature

  Capybara.server_host = 'lvh.me'
  Capybara.default_host = "http://#{Capybara.server_host}"
  Capybara.server_port = 4100 + ENV['TEST_ENV_NUMBER'].to_i
  Capybara.default_max_wait_time = 2
  Capybara.save_path = './tmp/capybara_output'
  Capybara.always_include_port = true # for correct app_host
  # Capybara.raise_server_errors = false

  config.before(:each, type: :feature) do
    default_url_options[:host] = "#{Capybara.default_host}:#{Capybara.server_port}" if respond_to?(:default_url_options)
    allow_any_instance_of(ActionController::Base).to receive(:protect_against_forgery?).and_return(true)
  end

  # Capybara.javascript_driver = :webkit

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :headless_chrome do |app|
    headless = 'headless'
    disable_gpu = 'disable-gpu'
    win_size = '--window-size=1300,768'
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: [headless, disable_gpu, win_size] }
    )

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   desired_capabilities: capabilities
  end
  Capybara.javascript_driver = :headless_chrome

  Capybara::Webkit.configure do |webkit|
    webkit.allow_url('lvh.me')
    webkit.allow_url('fonts.gstatic.com')
    webkit.allow_url('fonts.googleapis.com')
    webkit.allow_url('maxcdn.bootstrapcdn.com')
  end

  Capybara.register_server :puma do |app, port, host|
    require 'rack/handler/puma'
    Rack::Handler::Puma.run(app, Host: host, Port: port, Threads: '0:4', config_files: ['-'])
  end

  config.use_transactional_fixtures = false

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }

  config.before(:each) { DatabaseCleaner.strategy = :transaction }

  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }

  config.before(:each, type: :feature) { Capybara.app_host = "http://#{Capybara.server_host}" }

  config.before(:each) { DatabaseCleaner.start }

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
