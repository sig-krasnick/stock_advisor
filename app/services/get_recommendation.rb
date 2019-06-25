class GetRecommendation
  class << self
    def execute(last_price, current_price)
      case compare_prices(last_price, current_price)
      when -1
        'BUY'
      when 1
        'SELL'
      else
        'HOLD'
      end
    end

    private

    def compare_prices(last, current)
      last <=> current
    end
  end
end