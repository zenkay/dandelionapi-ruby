# encoding: UTF-8

require "dandelionapi/version"

require "dandelionapi/base"
require "dandelionapi/analysis"
require "dandelionapi/comparison"
require "dandelionapi/entity_extraction"
require "dandelionapi/text_similarity"
require "dandelionapi/language_detection"
require "dandelionapi/sentiment_analysis"

module Dandelionapi

  # Class method to set up configuration parameters
  #
  # @example
  #   Dandelionapi.configure do |c|
  #     c.token = "test"
  #   end
  #
  def self.configure(&block)
    yield @config ||= Configuration.new
  end

  # Return configuration parameters
  #
  # @example
  #   Dandelionapi.config.token
  #
  def self.config
    @config
  end

  # Container for configuration parameters
  #
  class Configuration
    attr_accessor :token, :endpoint, :path
  end

  # Exception raised for connection error
  #  
  class BadResponse < Exception; end

  # Exception raised when a mandatory parameter is missing
  #  
  class MissingParameter < Exception; end

  # Exception raised when more than one require parameter is given
  #  
  class TooManyParameters < Exception; end

  # Exception raised when a parameter is in the wrong format
  #  
  class WrongParameterFormat < Exception; end

end
