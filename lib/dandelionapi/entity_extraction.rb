# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi
  module EntityExtraction
    class Request < Base::Request

      ENDPOINT = "/nex/v1"

      MANDATORY_FIELDS = [
        "text",
        "url",
        "html",
        "html_fragment"
      ]

      OPTIONAL_FIELDS = [
        "lang",
        "min_confidence",
        "min_length",
        "social.hashtag",
        "social.mention",
        "include",
        "extra_types",
        "country",
        "custom_spots"
      ]

      FIELDS_FORMAT = {
        "text" => {type: String}, 
        "url" => {type: String}, 
        "html" => {type: String}, 
        "html_fragment" => {type: String},
        "lang" => {
          type: String, 
          valid: lambda {|value| ["de", "en", "fr", "it", "pt", "auto"].include? value}
        }, 
        "min_confidence" => {
          type: Float, 
          valid: lambda {|value| [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0].include? value}
        }, 
        "min_length" => {
          type: Integer, 
          valid: lambda {|value| value >= 2}
        }, 
        "social.hashtag" => {type: [TrueClass, FalseClass]}, 
        "social.mention" => {type: [TrueClass, FalseClass]}, 
        "include" => {
          type: Array, 
          valid: lambda {|values| values.all?{|value|["types", "categories", "abstract", "image", "lod", "alternate_labels"].include? value}}
        }, 
        "extra_types" => {
          type: Array, 
          valid: lambda {|values| values.all?{|value|["phone", "vat"].include? value}}
        }, 
        "country" => {
          type: String, 
          valid: lambda {|value| ["AD", "AE", "AM", "AO", "AQ", "AR", "AU", "BB", "BR", "BS", "BY", "CA", "CH", "CL", "CN", "CX", "DE", "FR", "GB", "HU", "IT", "JP", "KR", "MX", "NZ", "PG", "PL", "RE", "SE", "SG", "US", "YT", "ZW"].include? value}
        }, 
        "custom_spots" => {type: String}  
      }

      def analyze(options)

        params = filter_permitted_params options

        if required_params_missing? params
          raise MissingParameter.new "Please provide one of the following parameters: #{MANDATORY_FIELDS.join(", ")} as input"
        end

        if too_many_mandatory_parameters? params
          raise TooManyParameters.new "Please provide only one of the following parameters: #{MANDATORY_FIELDS.join(", ")} as input"        
        end

        verify_type params do |wrong_param|
          raise WrongParameterType.new "Type of #{wrong_param} should be #{FIELDS_FORMAT[wrong_param][:type]}"  
        end

        verify_format params do |wrong_param|
          raise WrongParameterFormat.new "Wrong format for #{wrong_param}"  
        end

        call(ENDPOINT, params)
      end

    end
  end
end