require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CSFood
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.after_initialize do
      begin
        ActiveRecord::Base.connection
      rescue ActiveRecord::NoDatabaseError
      else
        if ActiveRecord::Base.connection.table_exists? 'users'
          unless User.find_by(username: 'testuser1')
            100.times do |i|
              u = User.create(username: "testuser#{i + 1}", email: "user#{i + 1}@gmail.com", password: 'test1234', first_name: 'testuse', last_name: 'testuser', birthday: '1900/01/01', phone_number: '456-456-4567')
              u.orders.create(title: "testorder#{i + 1}", text: "This is order #{i + 1}", points: 2)
            end
          end
        end
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
