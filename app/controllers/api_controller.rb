class ApiController < ApplicationController
include HTTParty

URL = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=IBM&apikey=demo"

        def getData
        data = HTTParty.get(URL)

        if data.success?

            render json:data,status:200

        else
            render json:"Erro na requisição",status:404
        end

        end





end
