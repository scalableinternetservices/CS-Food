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
            u = User.create(username: 'testuser1', email: 'user1@gmail.com', password: 'test1234', first_name: 'testuse', last_name: 'testuser', birthday: '1900/01/01', phone_number: '456-456-4567')
            u.orders.create(title: 'testorder', text: 'This is an order', points: 2)
            u = User.create(username: 'testuser2', email: 'user2@gmail.com', password: 'test1234', first_name: 'testuse', last_name: 'testuser', birthday: '1900/01/01', phone_number: '456-456-4567')
            u.orders.create(title: 'testorder', text: 'This is an order', points: 2)
            u = User.create(username: 'testuser3', email: 'user3@gmail.com', password: 'test1234', first_name: 'testuse', last_name: 'testuser', birthday: '1900/01/01', phone_number: '456-456-4567')
            u.orders.create(title: 'testorder', text: 'This is an order', points: 2)
            u = User.create(username: 'testuser4', email: 'user4@gmail.com', password: 'test1234', first_name: 'testuse', last_name: 'testuser', birthday: '1900/01/01', phone_number: '456-456-4567')
            u.orders.create(title: 'testorder', text: 'This is an order', points: 2)
          end
        end
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
