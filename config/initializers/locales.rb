 
# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
 
# Permitted locales available for the application
I18n.available_locales = [:en, :es, :eo]
 
# Set default locale to something other than :en
if ENV['DEFAULT_LOCALE']
  I18n.default_locale = ENV['DEFAULT_LOCALE'] || 'en'
end