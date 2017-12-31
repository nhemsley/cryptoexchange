module Cryptoexchange::Exchanges
  module BtcMarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: BtcMarkets::Market::NAME
            )
          end
        end
      end
    end
  end
end
