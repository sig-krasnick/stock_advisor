class FetchStockPrices
  class << self
    def execute(symbol)
      security_api = Intrinio::SecurityApi.new

      opts = {
        start_date: 5.days.ago, # Date | Return prices on or after the date
        end_date: Date.today, # Date | Return prices on or before the date
        frequency: "daily", # String | Return stock prices in the given frequency
        page_size: 5, # Integer | The number of results to return
        next_page: nil # String | Gets the next page of data from a previous API call
      }

      begin
        result = security_api.get_security_stock_prices(symbol, opts).stock_prices.take(2)
      rescue Intrinio::ApiError => e
        puts "Exception when calling SecurityApi->get_security_stock_prices: #{e}"
      end
    end
  end
end