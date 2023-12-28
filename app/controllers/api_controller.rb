class ApiController < ApplicationController
include HTTParty

URL = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=IBM&apikey=demo"

def getData
 data = HTTParty.get(URL)

return render json:{data:data},status: :ok

end





end
