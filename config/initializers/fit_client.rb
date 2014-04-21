require 'fit/client'

Fit::Client.api_token = ENV['FIT_SERVICE_API_TOKEN']
Fit::Client.service_host = ENV['FIT_SERVICE_HOST']
Fit::Client.service_port = ENV['FIT_SERVICE_PORT']
Fit::Client.use_ssl = Rails.env.production?
