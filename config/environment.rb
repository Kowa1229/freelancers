# Load the Rails application.
require_relative 'application'

ActionMailer::Base.smtp_settings = {
    :user_name => ENV['app122029647@heroku.com'],
    :password => ENV['jghzbans2688'],
    :domain => 'heroku.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!