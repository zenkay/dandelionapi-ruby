# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi
  module Analysis

    class Request < Base::Request

      def analyze(options)
        params = filter_permitted_params options

        if required_params_missing? params
          raise MissingParameter.new "Please provide one of the following parameters: #{self.class::MANDATORY_FIELDS.join(", ")} as input"
        end

        if too_many_mandatory_parameters? params, 1
          raise TooManyParameters.new "Please provide only one of the following parameters: #{self.class::MANDATORY_FIELDS.join(", ")} as input"        
        end

        verify_format params do |wrong_param|
          raise WrongParameterFormat.new "Wrong format: #{self.class::FIELDS_FORMAT[wrong_param][:error_message]}"  
        end

        call(self.class::ENDPOINT, params)
      end

      protected

      def filter_permitted_params options
        params = {}
        options.each { |key, value| params[key.to_s] = value }
        params.select { |key,value| (self.class::MANDATORY_FIELDS + self.class::OPTIONAL_FIELDS).include? key }
      end

      def required_params_missing? params
        mandatory_fields_count(params) == 0
      end

      def too_many_mandatory_parameters? params, max
        mandatory_fields_count(params) > max
      end

      def mandatory_fields_count params
        (self.class::MANDATORY_FIELDS & params.keys).size
      end

      def verify_format params, &block
        params.each do |key, value|
          if self.class::FIELDS_FORMAT[key] and self.class::FIELDS_FORMAT[key][:valid]
            yield key unless self.class::FIELDS_FORMAT[key][:valid].call value
          end
        end
      end

    end
  end
end