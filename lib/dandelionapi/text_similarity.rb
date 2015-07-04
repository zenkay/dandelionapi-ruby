require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class TextSimilarity < Base

    ENDPOINT = "/datatxt/sim/v1"

    attr_accessor :text1, :url1, :html1, :html_fragment1, :text2, :url2, :html2, :html_fragment2, :lang, :bow

    def analyze(options)
      params = options
      call(ENDPOINT, params)
    end

  end

end