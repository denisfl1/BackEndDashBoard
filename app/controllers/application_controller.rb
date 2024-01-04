class ApplicationController < ActionController::API

    def encode_Token(payload)

        JWT.encode(payload,"secret")

    end


    def decode_Token

        auth_header = request.headers["Authorization"]

        if auth_header

            token = auth_header.split(' ').last
            token

            begin
                JWT.decode(token,"secret",true,algorithm:'HS256')
            
            rescue JWT::DecodeError

                nil

            end
            

    end

    end


    def authorized_user
        decode_token = decode_Token()

        if decode_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id:user_id)

        end

    end


    def authorize

        render json:{message:"Você não está autenticado"},status:401 unless authorized_user

    end

end
