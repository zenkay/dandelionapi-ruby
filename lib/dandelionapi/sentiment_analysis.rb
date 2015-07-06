# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class SentimentAnalysis < Base

    ENDPOINT = "/datatxt/sent/v1"

    attr_accessor :text, :url, :html, :html_fragment, :lang

    def analyze(options)

      raise MissingParameters.new("Please provide one of the following parameters: text, url, html or html_fragment") if ([:text, :url, :html, :html_fragment] & options.keys).empty?

      params = options
      call(ENDPOINT, params)
    end

  end

end