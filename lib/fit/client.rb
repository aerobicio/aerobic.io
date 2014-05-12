require 'fit/client/service'
require 'fit/client/workout'

module Fit
  # Fit::Client provides an interface for interactive with the aerobic.io
  # fit-service.
  #
  module Client
    class << self
      attr_accessor :api_token, :service_host, :service_port, :use_ssl
    end
  end
end
