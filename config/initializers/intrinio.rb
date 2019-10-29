require 'intrinio-sdk'

Intrinio.configure do |config|
  config.api_key['api_key'] = ENV['API_KEY']
end