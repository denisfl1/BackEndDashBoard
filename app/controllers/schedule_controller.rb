class ScheduleController < ApplicationController


        def get_schedules

        @schedules = Schedule.where(specialty: params[:specialty], hour: params[:timeSchedule], date: params[:date])
       
        crms = @schedules.map {|data| data.crm}

        @doctor = Doctor.where(specialty: params[:specialty]).reject{|data|crms.include?(data[:crm])}
        
        if @doctor[0]

          render json:@doctor,status:200
   
        else

          render json: "Não há disponibilidade",status:404

        end

    end

         def CreateSchedules

           @NewSchedule = Schedule.create(doctor:params[:doctor],specialty:params[:specialty],crm:params[:crm],date:params[:date],hour:params[:timeSchedule],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email])

           render json: "Agendado com sucesso!",status:200

         end
    


end
