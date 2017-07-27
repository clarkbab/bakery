# frozen_string_literal: true

module Bakery
  ##
  # This class holds the configuration for the bakery module.
  class Configuration
    attr_accessor :logging, :logging_method, :logpath

    ##
    # This creates a new configuration.
    def initialize
      set_defaults
    end

    private

    ##
    # This method sets the default values for the configuration.
    def set_defaults
      ##
      # Logging is disabled by default.
      #
      # Possible values are true/false.
      @logging = false

      ##
      # The default logging method is to a file.
      #
      # Possible values are :file and :stdout.
      @logging_method = :file

      ##
      # The default logfile is at 'log/bakery.log',
      #
      # Possible values are any valid filepath. The logging method won't create
      # directories so you must create these manually.
      @logpath = 'log/bakery.log'
    end
  end
end
