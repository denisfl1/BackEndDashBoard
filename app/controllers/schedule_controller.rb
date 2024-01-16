class ScheduleController < ApplicationController


        def get_schedules

        @schedules = Schedule.all

        if  @schedules

            render json:@schedules,status:200

        else

            render json:"Items não encontrados",status:404

        end

    end


end
