
class FetchCompanyDetails
  class << self
    def execute(symbol)
      company_api = Intrinio::CompanyApi.new
      begin
        company_info = company_api.get_company(symbol)
        stock_prices = FetchStockPrices.execute(symbol)
        return company_info, stock_prices
      rescue Intrinio::ApiError => e
        puts "Exception when calling SecurityApi->get_security_stock_prices: #{e}"
      end
    end
  end
end
