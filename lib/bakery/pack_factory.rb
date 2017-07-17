# frozen_string_literal: true

module Bakery
  ##
  # This class represents a utility for creating Packs.
  class PackFactory
    ##
    # This method builds an array of packs from a +pack_config+ array.
    # The format of pack_config is:
    #
    #   pack_config = [
    #     { code: 'CODE', price: 9.99, quantity: 5}
    #   ]
    #
    # This method raises an InvalidPackConfig exception if +pack_config+
    # doesn't have the correct format.
    def build(pack_config)
      pack_config.map do |config|
        # Raise exception if invalid config is passed.
        raise Bakery::InvalidPackConfig unless valid_config?(config)

        build_pack(config)
      end
    end

    private

    ##
    # This method builds a pack from a +config+ hash.
    def build_pack(config)
      Pack.new(
        code: config[:code],
        price: config[:price],
        quantity: config[:quantity]
      )
    end

    ##
    # This method checks that the +config+ has a valid format.
    # +config+ must contain code, price and quantity keys.
    def valid_config?(config)
      # Get passed keys.
      keys = config.keys

      # Are all required keys present?
      %i[code price quantity].all? { |key| keys.include?(key) }
    end
  end
end
