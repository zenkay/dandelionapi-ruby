require "faraday"
require "faraday_middleware"
require "json"

module Dandelionapi

  class EntityExtraction < Base

    ENDPOINT = "/datatxt/nex/v1"

    attr_accessor :text, :url, :html, :html_fragment, 
    	:lang, :min_confidence, :min_length, :social_hashtag, 
    	:social_mention, :include, :extra_types, :country, 
    	:custom_spots

    def analyze(options)

      raise MissingParameters.new("Please provide one of the following parameters: text, url, html or html_fragment") if ([:text, :url, :html, :html_fragment] & options.keys).empty?

      params = options
      call(ENDPOINT, params)
    end

  end

end