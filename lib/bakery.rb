# frozen_string_literal: true

##
# Here the module level methods of the Bakery application are defined.
module Bakery
  ##
  # This method accepts a block and yields the configuration object so that the
  # settings can be configured.
  def self.configure
    yield configuration
  end

  ##
  # This method returns the memoized configuration object.
  def self.configuration
    @configuration ||= Configuration.new
  end

  ##
  # This method returns the memoized logger for the application.
  def self.logger
    @logger ||= Logger.new(stream: logger_stream)
  end

  private_class_method :logger_stream

  ##
  # This method reads the configuration and returns the stream to be used for
  # logging.
  def self.logger_stream
    case configuration.logger_method
    when :file
      # Get log path configuration.
      logpath = configuration.logpath

      raise DirectoryNonExistant unless Dir.exist?(logpath)

      # Open the IO stream.
      open(logpath, 'w')
    when :stdout
      STDOUT
    else
      raise UnknownLoggerMethod
    end
  end
end

require_relative 'bakery/catalogue'
require_relative 'bakery/configuration'
require_relative 'bakery/exceptions'
require_relative 'bakery/line'
require_relative 'bakery/line_solver'
require_relative 'bakery/logger'
require_relative 'bakery/order_parser'
require_relative 'bakery/pack'
require_relative 'bakery/pack_factory'
require_relative 'bakery/receipt_builder'

##

require 'pry'
