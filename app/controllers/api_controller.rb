class ApiController < ApplicationController
include HTTParty



        def getData
        # data = HTTParty.get(URL)

        # if data.success?

            render json:DATA,status:200

        # else
        #     render json:"Erro na requisição",status:404
        # end

        end





end
