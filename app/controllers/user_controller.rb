class UserController < ApplicationController
before_action :authorize_admin, only:[:register_admin]

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

        def register_admin

            search = User.find_by(email:user_params[:email])

            if search
    
                return render json:{error:"Usuário já existe"},status:404
    
            end
            
            
            @user2 = User.create(user_params_admin)

      
            if @user2.valid?
    
                token = encode_Token({user:@user2})
                render json:"Criado com sucesso",status:200
    
            else
                render json:{error:"Usuário ou senha inválidos"},
                status: 404
            
            end

        end

       
        def login

            @user = User.find_by(email:user_params[:email])

            if @user && @user.authenticate(user_params[:password])
                token = encode_Token({id:@user.id,name:@user.name,email:@user.email,admin:@user.admin,firstTime:@user.firstTime})

                render json:{user:@user,token:token},status:200

            else

                render json:{error:"Usuário ou senha inválidos"}, status:404

            end

        end


        def get_Users

            @user = User.all

            render json:@user,status:200

        end


        def change_Password

            @user = User.find_by(email:user_params[:email])

            if @user && @user.firstTime?

                @user.update(password:params[:password],firstTime:false)

                @user = User.find_by(email:user_params[:email])

                render json:{user:@user},status:200

            end

        end


        def delete_User

            @user = User.find_by(id:user_params[:id])

            if @user

                @user.destroy

                render json: "Apagado com sucesso",status:200

            else

                render json: "Usuário não encontrado",status:404

            end


        end

    private

    def user_params
       
        params.permit(:name,:email,:password,:adress,:number_adress,:contact_number,:zipCode,:neighborhood)
        

    end

    def user_params_admin

        params[:password] = params[:cpf][0,5]
        params[:firstTime] = true

        params.permit(:name,:email,:password,:adress,:number_adress,:contact_number,:zipCode,:neighborhood,:firstTime)

    end

end
