module Cryptoexchange::Exchanges
  module BtcMarkets
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BtcMarkets::Market::API_URL}/market/#{market_pair.base}/#{market_pair.target}/tick"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = BtcMarkets::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['bestAsk'])
          ticker.bid       = NumericHelper.to_d(output['bestBid'])
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.volume    = NumericHelper.to_d(output['volume24h'])
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
