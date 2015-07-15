# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi
  module LanguageDetection

  	class Request < Analysis::Request

      ENDPOINT = "/li/v1"

      MANDATORY_FIELDS = [
        "text",
        "url",
        "html",
        "html_fragment"
      ]

      OPTIONAL_FIELDS = [
        "clean"
      ]

      FIELDS_FORMAT = {
        "text" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'text needs to be String'
        }, 
        "url" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'url needs to be String'
        },  
        "html" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'html needs to be String'
        },  
        "html_fragment" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'html_fragment needs to be String'
        }, 
        "clean" => {
          valid: lambda {|value| (value.is_a? TrueClass or value.is_a? FalseClass)},
          error_message: 'clean needs to be Boolean'
        }, 
      }

    end

  end
end