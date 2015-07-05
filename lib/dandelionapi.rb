# encoding: UTF-8

require "dandelionapi/version"

require "dandelionapi/base"
require "dandelionapi/entity_extraction"
require "dandelionapi/text_similarity"
require "dandelionapi/language_detection"

module Dandelionapi

  # Class method to set up configuration parameters
  #
  # @example
  #   Dandelionapi.configure do |c|
  #     c.app_id = "test"
  #   end
  #
  def self.configure(&block)
    yield @config ||= Configuration.new
  end

  # Return configuration parameters
  #
  # @example
  #   Dandelionapi.config.app_id
  #
  def self.config
    @config
  end

  # Container for configuration parameters
  #
  class Configuration
    attr_accessor :app_id, :app_key, :endpoint
  end

  # Exception raised for connection error
  #  
  class BadResponse < Exception; end

  # Exception raised when a mandatory parameter is missing
  #  
  class MissingParameters < Exception; end
end
