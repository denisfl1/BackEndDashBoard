class ScheduleController < ApplicationController


        def find_schedule

        schedules = Schedule.where(specialty: params[:specialty], hour: params[:timeSchedule], date: params[:date])
       
        crms = schedules.map {|data| data.crm}

        doctor = Doctor.where(specialty: params[:specialty]).reject{|data|crms.include?(data[:crm])}
        
        if doctor[0]

          render json:doctor,status:200
   
        else

          render json: "Não há disponibilidade",status:404

        end

    end

         def CreateSchedules

            search = Schedule.where(crm:params[:crm],date:params[:date],hour:params[:timeSchedule])


            if search[0]

                render json: "Agendamento já existe!",status:404
                
            else

            newSchedule = Schedule.create(doctor:params[:doctor],specialty:params[:specialty],crm:params[:crm],date:params[:date],hour:params[:timeSchedule],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email])

                render json: "Agendado com sucesso!",status:200

            end

         end
    

         def GetSchedules

            getschedules = Schedule.all

            if getschedules

            render json: getschedules, status:200

            else 
                
            render json: "Items não encontrados",status:404

            end

         end

end
