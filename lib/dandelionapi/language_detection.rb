# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class LanguageDetection

  	include Base

    ENDPOINT = "/li/v1"

    attr_accessor :text, :url, :html, :html_fragment, :clean

    def analyze(options)

      raise MissingParameter.new("Please provide one of the following parameters: text, url, html or html_fragment") if ([:text, :url, :html, :html_fragment] & options.keys).empty?

      params = options
      call(ENDPOINT, params)
    end

  end

end