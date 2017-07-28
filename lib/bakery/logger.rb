# frozen_string_literal: true

require 'date'

module Bakery
  ##
  # This class handles the logging for the application.
  class Logger
    ##
    # Creates a new Logger given an IO +stream+.
    def initialize(args)
      @stream = args[:stream]
    end

    ##
    # This method writes a log line to the configured IO object.
    def log(action, message)
      @stream.write "#{DateTime.now}[#{action.upcase}]: #{message}"
    end
  end
end
