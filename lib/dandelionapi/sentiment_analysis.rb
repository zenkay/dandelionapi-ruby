# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  module SentimentAnalysis

    class Request < Base::Request

      ENDPOINT = "/sent/v1"

      MANDATORY_FIELDS = [
        "text",
        "url",
        "html",
        "html_fragment"
      ]

      OPTIONAL_FIELDS = [
        "lang"
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
        "lang" => {
          valid: lambda {|value| (value.is_a? String and ["de", "en", "fr", "it", "pt", "auto"].include? value)},
          error_message: 'lang needs to be one of the following values: "de", "en", "fr", "it", "pt", "auto"'
        } 
      }

    end

  end

end