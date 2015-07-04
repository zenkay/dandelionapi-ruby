require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class LanguageDetection < Base

    ENDPOINT = "/datatxt/li/v1"

    attr_accessor :text, :url, :html, :html_fragment, :clean

    def analyze(options)
      params = options
      call(ENDPOINT, params)
    end

  end

end