require 'json'
require 'net/http'

module Fit
  module Client
    # Fit::Client::Service is responsible for HTTP interactions with the
    # aerobic.io fit-service.
    #
    class Service
      HEADERS = { 'Content-Type' => 'application/json' }

      def initialize
        @request = nil
      end

      def post(end_point, params)
        @request = Net::HTTP::Post.new(end_point, HEADERS)
        apply_basic_auth
        prepare_request_body(params)
        response = http.start { |http| http.request(@request) }
        parse_response(response)
      rescue Timeout::Error
        {}
      end

      private

      def apply_basic_auth
        @request.basic_auth(Fit::Client.api_token, '')
      end

      def http
        net_http = Net::HTTP.new(Fit::Client.service_host,
                                 Fit::Client.service_port)
        net_http.use_ssl = Fit::Client.use_ssl
        net_http
      end

      def parse_response(response)
        if response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)
        else
          {}
        end
      end

      def prepare_request_body(params)
        @request.body = params.to_json
      end
    end
  end
end
