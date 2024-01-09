class UserController < ApplicationController


    def register   
    
        search = User.find_by(email:user_params[:email])

        if search

            return render json:{error:"Usuário já existe"},status:404

        end

        @user = User.create(user_params)

      
        if @user.valid?

            token = encode_Token({user_id:@user.id})
            render json:{user:@user,token:token},status:200

        else
            render json:{error:"Usuário ou senha inválidos"},
            status: 404
        
        end
    end

       
        def login

            @user = User.find_by(email:user_params[:email])

            if @user && @user.authenticate(user_params[:password])
                token = encode_Token({id:@user.id,name:@user.name,email:@user.email})

                render json:{user:@user,token:token},status:200

            else

                render json:{error:"Usuário ou senha inválidos"}, status:404

            end

        end


    private

    def user_params

        params.permit(:name,:email,:password)
    
    end

end
