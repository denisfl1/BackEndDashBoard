class DoctorController < ApplicationController
before_action :authorize ,only:[]
before_action :authorize_admin ,only:[:get_Doctors,:get_Doctor,:createDoctor,:delete_Doctor,:edit_Doctor]


    def generate_Doctor

          values ={
            "ClínicaGeral": ["Dr. Carlos Silva", "Dra. Ana Costa", "Dr. José Oliveira", "Dra. Maria Santos"],
            "Cardiologia": ["Dr. Sofia Pereira", "Dr. Roberto Fernandes", "Dra. João Lima", "Dr. Laura Mendes"],
            "Ortopedia": ["Dr. Ricardo Martins", "Dra. Isabel Almeida", "Dr. André Sousa", "Dra. Carolina Santos"],
            "Dermatologia": ["Dra. Gabriela Pereira", "Dr. Pedro Rocha", "Dra. Lucas Oliveira", "Dr. Beatriz Silva"],
            "Neurologia": ["Dra. Marta Costa", "Dr. Rodrigo Pereira", "Dra. Clara Santos", "Dr. André Silva"],
            "Ginecologia Obstetricia": ["Dra. Laura Oliveira", "Dr. Paulo Mendonça", "Dra. Mariana Rocha", "Dr. Gustavo Alves"],
            "Oftalmologia": ["Dr. João Mendes", "Dra. Ana Lima", "Dr. Miguel Rocha", "Dra. Beatriz Almeida"],
            "Pediatria": ["Dra. Carolina Santos", "Dr. Luís Oliveira", "Dra. Sofia Costa", "Dr. Eduardo Almeida"],
            "Psiquiatria": ["Dr. André Santos", "Dra. Mariana Lima", "Dr. Guilherme Costa", "Dra. Isabel Rocha"],
            "Endocrinologia": ["Dra. Rita Mendes", "Dr. Gustavo Pereira", "Dra. Beatriz Costa", "Dr. Luís Rocha"],
            "Otorrinolaringologia": ["Dr. João Oliveira", "Dra. Clara Alves", "Dr. Rafael Lima", "Dra. Sofia Rocha"],
            "Radiologia": ["Dra. Isabel Almeida", "Dr. Pedro Costa", "Dra. Marta Lima", "Dr. Lucas Pereira"],
            "Urologia": ["Dr. André Rocha", "Dra. Carolina Costa", "Dr. Gustavo Almeida", "Dra. Mariana Silva"],
            "CirurgiaGeral": ["Dr. Rodrigo Almeida", "Dra. Rita Silva", "Dr. Eduardo Rocha", "Dra. Laura Costa"],
            "Hematologia": ["Dra. Gabriela Costa", "Dr. Rafael Pereira", "Dra. Marta Almeida", "Dr. Luís Santos"],
            "Dermatologia": ["Dra. Sofia Rocha", "Dr. João Pereira", "Dra. Beatriz Lima", "Dr. Gustavo Costa"],
            "Gastroenterologia": ["Dr. Eduardo Lima", "Dra. Mariana Costa", "Dr. Luís Rocha", "Dra. Carolina Almeida"],
            "Nefrologia": ["Dra. Marta Almeida", "Dr. André Lima", "Dra. Clara Santos", "Dr. Rafael Costa"],
            "Reumatologia": ["Dr. Luís Santos", "Dra. Sofia Costa", "Dr. Gustavo Alves", "Dra. Beatriz Rocha"],
            "Psicologia": ["Psic. Ana Silva", "Psic. João Santos", "Psic. Mariana Lima", "Psic. Lucas Rocha"]
          }


          values.each do |spec,name|

          name.each do |nome|

            if nome.include?("Dr.")
                genner = "Masculino"
            elsif nome.include?("Dra.")
                genner = "Feminino"
            end
            Doctor.create(
            id:incrementID,name:nome,specialty:spec,
            crm:randomCRM,email:"email@hotmail.com",
            number:randomNumber,sex:genner
            )
          end

          end

          render json:"Criado com Sucesso!",status: 200

    end


    def createDoctor


          @user = Doctor.create(user_params)

          if @user.valid?

            render json:"Criado com Sucesso!",status: 200

        else
            render json:{error:"Dados inválidos"},
            status: 404

          end

    end

        def get_Doctors

            doctor = Doctor.all

            render json:doctor,status: 200

        end

        def get_Doctor

            doctor = Doctor.find_by(id:params[:id])

            if doctor

                render json:doctor,status:200

            else

                render json:"Usuário não encontrado",status:404

            end

        end

        def edit_Doctor


            doctor = Doctor.find_by(id:params[:id])

            if doctor

                doctor.update(
                name:params[:name],specialty:params[:specialty],
                crm:params[:crm],email:params[:email],
                number:params[:number],sex:params[:sex])

                render json:"Alterado com Sucesso!",status:200

            else

                render json:"Usuário não encontrado",status:404

            end



        end


        def delete_Doctor

            doctor = Doctor.find_by(id:params[:id])

            if doctor

                doctor.destroy

                render json:"Apagado com sucesso",status:200

            else

                render json:"Usuário não encontrado",status:404

            end

        end


        private
        def user_params

            params.permit(:name,:specialty,:email,:crm,:number,:sex)

        end

        private
        def randomCRM

            rand(10000000).to_i

        end


        private
        def incrementID
            result = []
            count = 1
                loop do
                    result <<count
                    break if count == 84

                    count +=1
                end
                result
        end

        private
        def randomNumber

         rand(* 1000000000).to_i

        end

end
