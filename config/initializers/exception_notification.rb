if Rails.env.production?
  require 'exception_notification/rails'
  require 'exception_notification/sidekiq' if defined?(Sidekiq)

  ExceptionNotification.configure do |config|
    # Ignore additional exception types.
    # ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
    # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

    # Email notifier sends notifications by email.
    config.add_notifier :email, {
      :email_prefix         => "[#{ENV['WEBSITE_ABBREVIATION'] || "EW"}] ",
      :sender_address       => %{"Postmaster" <website@example.com>},
      :exception_recipients => (ENV["WEBSITE_POSTMASTER_ERROR_EMAIL"] || %w{darius.roberts@gmail.com})
    }

  end
end
