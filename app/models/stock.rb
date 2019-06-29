class Stock < ApplicationRecord
  class << self
    def fetch(symbol)
      @stocks = Stock.where('identifier LIKE ?', "%#{symbol}%")
      return @stocks if @stocks.count > 0 && current_prices?

      fetch_stock_remote(symbol)
    end

    private

    def fetch_stock_remote(symbol)
      result = FetchCompanyDetails.execute(symbol)
      return [] unless result
      max_price, min_price = sort_price(result[1])

      stock = Stock.find_or_create_by(identifier: symbol)
      @stocks = [stock.update(description: result[0].short_description,
                              last_price: min_price.close, current_price: max_price.close,
                              created_at: DateTime.now, updated_at: max_price.date)]
    end

    def sort_price(price_list)
      max_price = get_max_price(price_list)
      min_price = get_min_price(price_list)
      return max_price, min_price
    end

    def get_max_price(stock_prices)
      stock_prices.max { |a, b| a.date <=> b.date }
    end

    def get_min_price(stock_prices)
      stock_prices.min { |a, b| a.date <=> b.date }
    end

    def current_prices?
      (closing_date - @stocks.first.updated_at.to_date).to_i <= 1
    end

    def closing_date
      closing_date = Date.today.saturday? ? 1.day.ago.to_date
                        : Date.today.sunday? ? 2.days.ago.to_date
                        : Date.today
    end
  end

  def recommendation
    GetRecommendation.execute(last_price, current_price)
  end

  def delta
    (((current_price - last_price) / last_price) * 100.0).round(3).to_f
  end
end
