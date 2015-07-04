require "dandelionapi/version"

require "dandelionapi/base"
require "dandelionapi/entity_extraction"
require "dandelionapi/text_similarity"
require "dandelionapi/language_detection"

module Dandelionapi
  def self.configure(&block)
    yield @config ||= Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    attr_accessor :app_id, :app_key, :endpoint
  end

  class BadResponse < Exception; end
  class BadParameters < Exception; end
end
