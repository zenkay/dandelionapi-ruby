# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi
  module Base

    class Request

      def call(endpoint, params)
        begin
          params = params.merge(
            :$app_id => Dandelionapi.config.app_id,
            :$app_key => Dandelionapi.config.app_key
          )
          conn = Faraday.new(url: Dandelionapi.config.endpoint) do |faraday|
            faraday.request  :url_encoded
            faraday.adapter  Faraday.default_adapter
          end
          response = conn.post "#{Dandelionapi.config.path}#{endpoint}", params
          JSON.parse response.body
        rescue Exception => e
          raise Dandelionapi::BadResponse
        end
      end

      def filter_permitted_params options
        params = {}
        options.each { |key, value| params[key.to_s] = value }
        params.select { |key,value| (self.class::MANDATORY_FIELDS + self.class::OPTIONAL_FIELDS).include? key }
      end

      def required_params_missing? params
        mandatory_fields_count(params) == 0
      end

      def too_many_mandatory_parameters? params
        mandatory_fields_count(params) > 1
      end

      def mandatory_fields_count params
        (self.class::MANDATORY_FIELDS & params.keys).size
      end

      def verify_type params, &block
        params.each do |key, value|
          formats = [self.class::FIELDS_FORMAT[key][:type]] unless self.class::FIELDS_FORMAT[key][:type].is_a? Array
          unless formats.include? value.class
            yield key
          end
        end
      end

      def verify_format params, &block
        params.each do |key, value|
          if self.class::FIELDS_FORMAT[key] and self.class::FIELDS_FORMAT[key][:valid]
            yield key unless self.class::FIELDS_FORMAT[key][:valid].call value
          end
        end
      end

    end

    class Response

      attr_accessor :timestamp, :time, :lang, :annotations

      def initialize(object)
        timestamp = object[:timestamp]
        time = object[:time]
        lang = object[:lang]
        annotations = object[:annotations]
      end
      
    end
  end
end