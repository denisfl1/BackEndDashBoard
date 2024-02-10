class ScheduleController < ApplicationController
    require "json"
    require 'date'
    before_action :authorized_user, only:[:GetSchedule_One,:GetSchedules]
    before_action :authorize_admin, only:[:Edit_Schedule,:Delete_Schedules,:find_schedule]

        def find_schedule

        schedules = Schedule.where(
         specialty: params[:specialty],
         hour: params[:timeSchedule],
         date: params[:date]).reject{|data|!data.status.include?("Active")}

        crms = schedules.map {|data| data.crm}

        doctor = Doctor.where(specialty:params[:specialty]).reject{|data|crms.include?(data[:crm])}

        if doctor[0]

          render json:doctor,status:200

        else

          render json: "Não há disponibilidade",status:404

        end

    end

         def CreateSchedules

            search = Schedule.where(
            crm:params[:crm],
            date:params[:date],
            hour:params[:timeSchedule]).reject{|data|
            !data.status.include?("Active")}

            search1 = Schedule.where(
            date:params[:date],
            hour:params[:timeSchedule],
            patient_Name:params[:patient_Name],
            patient_Email:params[:patient_Email]).reject{|data|
            !data.status.include?("Active")}

            search2 = Schedule.where(
            date:params[:date],
            specialty: params[:specialty],
            patient_Name:params[:patient_Name],
            patient_Email:params[:patient_Email]).reject{|data|
            !data.status.include?("Active")}

            searchSpec = search1.select{|data|data.specialty == params[:specialty]}

            if search[0]

                render json: "Agendamento já existe!",status:404

            elsif search1[0]

                if searchSpec[0]

                    render json: "#{params[:specialty]} já marcado!",status:404


                elsif  search1[0]

                    render json: "#{search1[0].specialty} marcado neste horário!",status:404

                end



            elsif search2[0]

                render json: "#{params[:specialty]} já marcado!",status:404

            else

            newSchedule = Schedule.create(
            doctor:params[:doctor],
            specialty:params[:specialty],
            crm:params[:crm],
            date:params[:date],
            hour:params[:timeSchedule],
            patient_Name:params[:patient_Name],
            patient_Email:params[:patient_Email])

                render json: "Agendado com sucesso!",status:200

            end

         end


        def GetSchedules

            getschedules = Schedule.all


            if check_admin

                if  getschedules

                render json: getschedules, status:200

                 else

                render json: "Não há agendamentos",status:404

                end


            else

                findMyUser  = User.find_by(id:authorized_user)
                name = findMyUser.name
                email = findMyUser.email

                find_schedule = Schedule.where(patient_Name:name,patient_Email:email)

                if find_schedule[0]

                render json: find_schedule,status:200

                else

                render json:"Não há agendamentos marcados",status:404

                end

            end

        end


         def GetSchedule_One

            getschedules = Schedule.find_by(id:params[:id])

            if getschedules

            render json: getschedules, status:200

            else

            render json: "Agendamento não encontrado",status:404

            end

         end


         def Edit_Schedule

            myID = params[:id].to_i

            search = Schedule.find_by(id:params[:id])

            search1 = Schedule.where(
            crm:params[:crm],
            date:params[:date],
            hour:params[:timeSchedule]).reject{|data|
            !data.status.include?("Active")}.select{|data|data.id != myID}

            search2 = Schedule.where(
            date:params[:date],
            hour:params[:timeSchedule],
            patient_Name:params[:patient_Name],
            patient_Email:params[:patient_Email]).reject{|data|
            !data.status.include?("Active")}.select{|data|data.id != myID}

            search3 = Schedule.where(
            date:params[:date],
            specialty: params[:specialty],
            patient_Name:params[:patient_Name],
            patient_Email:params[:patient_Email]).reject{|data|
            !data.status.include?("Active")}.select{|data| data.id != myID}

            searchSpec = search2.select{|data|data.specialty == params[:specialty]}


            if search1[0]

               render json: "Agendamento já existe!",status:404


            elsif search2[0]

                if searchSpec[0]

                    render json: "#{params[:specialty]} já marcado!",status:404

                elsif search2[0]

                    render json: "#{params[:specialty]} marcado nesse horário!",status:404

                end



            elsif search3[0]

                render json:"#{params[:specialty]} já marcado!",status:404


            elsif search

                search.update(doctor:params[:doctor],specialty:params[:specialty],
                crm:params[:crm],date:params[:date],hour:params[:timeSchedule],
                patient_Name:params[:patient_Name],patient_Email:params[:patient_Email])

                render json:"Alterado com Sucesso!",status:200

            else

                render json:"Agendamento não encontrado",status:404

            end


         end


         def Delete_Schedules

            search = Schedule.find_by(id:params[:id])

            if search

                search.destroy

                render json:"Apagado com Sucesso!",status:200

            else

                render json:"Agendamento não econtrado",status:404

            end


         end


         def Validate_Schedule

            searchSchedules = Schedule.find_by(id:params[:id])
            qr_Reader = params[:result]

            if  searchSchedules

                schedule_List = [searchSchedules].map{|data|
               [
                data.id,
                data.doctor,
                data.specialty,
                data.crm,
                data.date,
                data.hour,
                data.patient_Name,
                data.patient_Email,
                data.created_at,
                data.status]}[0]


                 schedule_Scanned = [qr_Reader].map{|data|data.values}[0]
                 schedule_Scanned[8] = DateTime.parse(schedule_Scanned[8]).strftime("%Y-%m-%d %H:%M:%S UTC")

                 schedule_Scanned.delete_at(9)

                schedule_List[8] = schedule_List[8].strftime("%Y-%m-%d %H:%M:%S UTC")

                 schedule_List = schedule_List
                 schedule_Scanned = schedule_Scanned


                 for i in 0... (schedule_List.size)- 1

                    if  schedule_List[i] != schedule_Scanned[i]

                      verify = true

                    end

                  end


                if verify

                    render json:"Agendamento inválido",status: 404

                else

                    if schedule_List[9] != schedule_Scanned[9]

                        render json:"Agendamento já finalizado",status: 404

                    else

                        searchSchedules.update(status:"Finished")

                        render json:"Validado com Sucesso!",status: 200

                    end

                end


                else

                  render json: "Agendamento não encontrado!",status:404

              end


        end

end
