# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi
  module EntityExtraction
    
    class Request < Analysis::Request

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
        "text" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'text needs to be a String'
        }, 
        "url" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'url needs to be a String'
        },  
        "html" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'html needs to be a String'
        },  
        "html_fragment" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'html_fragment needs to be a String'
        }, 
        "lang" => {
          valid: lambda {|value| (value.is_a? String and ["de", "en", "fr", "it", "pt", "auto"].include? value)},
          error_message: 'lang needs to be one of the following values: "de", "en", "fr", "it", "pt", "auto"'
        }, 
        "min_confidence" => { 
          valid: lambda {|value| (value.is_a? Float and [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0].include? value) },
          error_message: 'wrong format'
        }, 
        "min_length" => {
          valid: lambda {|value| (value.is_a? Integer and value >= 2) },
          error_message: 'wrong format'
        }, 
        "social.hashtag" => {
          valid: lambda {|value| (value.is_a? TrueClass or value.is_a? FalseClass)},
          error_message: 'wrong format'
        }, 
        "social.mention" => {
          valid: lambda {|value| (value.is_a? TrueClass or value.is_a? FalseClass)},
          error_message: 'wrong format'
        }, 
        "include" => {
          valid: lambda {|values| (values.is_a? Array and values.all?{|value|["types", "categories", "abstract", "image", "lod", "alternate_labels"].include? value})},
          error_message: 'wrong format'
        }, 
        "extra_types" => {
          valid: lambda {|values| (values.is_a? Array and values.all?{|value|["phone", "vat"].include? value})},
          error_message: 'wrong format'
        }, 
        "country" => {
          valid: lambda {|value| ["AD", "AE", "AM", "AO", "AQ", "AR", "AU", "BB", "BR", "BS", "BY", "CA", "CH", "CL", "CN", "CX", "DE", "FR", "GB", "HU", "IT", "JP", "KR", "MX", "NZ", "PG", "PL", "RE", "SE", "SG", "US", "YT", "ZW"].include? value},
          error_message: 'wrong format'
        }, 
        "custom_spots" => {
          valid: lambda {|value| value.is_a? String},
          error_message: 'custom_spots needs to be a String'
        }
      }

    end
  end
end