# encoding: UTF-8

require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class TextSimilarity

  	class Request < Comparison::Request

	    ENDPOINT = "/sim/v1"

      MANDATORY_FIELDS_1 = [
        "text1",
        "url1",
        "html1",
        "html_fragment1"
      ]

      MANDATORY_FIELDS_2 = [
        "text2",
        "url2",
        "html2",
        "html_fragment2"
      ]

      OPTIONAL_FIELDS = [
        "lang",
        "bow"
      ]

	    def compare(options)
	      params = options
	      call(ENDPOINT, params)
	    end

    end
  end

end