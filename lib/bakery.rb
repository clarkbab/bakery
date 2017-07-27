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
end

require_relative 'bakery/catalogue'
require_relative 'bakery/configuration'
require_relative 'bakery/exceptions'
require_relative 'bakery/line'
require_relative 'bakery/line_solver'
require_relative 'bakery/order_parser'
require_relative 'bakery/pack'
require_relative 'bakery/pack_factory'
require_relative 'bakery/receipt_builder'

##

require 'pry'
