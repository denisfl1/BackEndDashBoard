class ScheduleController < ApplicationController
        

        def find_schedule

        schedules = Schedule.where(specialty: params[:specialty], hour: params[:timeSchedule], date: params[:date]).reject{|data|!data.status.include?("Active")}
       
        crms = schedules.map {|data| data.crm}

        doctor = Doctor.where(specialty: params[:specialty]).reject{|data|crms.include?(data[:crm])}
        
        if doctor[0]

          render json:doctor,status:200
   
        else

          render json: "Não há disponibilidade",status:404

        end

    end

         def CreateSchedules

            search = Schedule.where(crm:params[:crm],date:params[:date],hour:params[:timeSchedule]).reject{|data| !data.status.include?("Active")}
            search1 = Schedule.where(date:params[:date],hour:params[:timeSchedule],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email]).reject{|data| !data.status.include?("Active")}
            search2 = Schedule.where(date:params[:date],specialty: params[:specialty],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email]).reject{|data| !data.status.include?("Active")}
            searchSpec = search1.select{|data|data.specialty == params[:specialty]}

            if search[0]

                render json: "Agendamento já existe!",status:404
            
            elsif search1[0]
                
                if searchSpec[0]

                    render json: "#{params[:specialty]} já marcado!",status:404


                elsif  search1[0]

                    render json: "#{params[:specialty]} marcado neste horário!",status:404

                end

               
                                  
            elsif search2[0]

                render json: "#{params[:specialty]} já marcado!",status:404

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
            search1 = Schedule.where(crm:params[:crm],date:params[:date],hour:params[:timeSchedule]).reject{|data| !data.status.include?("Active")}.select{|data| data.id != myID}
              
            search2 = Schedule.where(date:params[:date],hour:params[:timeSchedule],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email]).reject{|data| !data.status.include?("Active")}.select{|data| data.id != myID}
            search3 = Schedule.where(date:params[:date],specialty: params[:specialty],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email]).reject{|data| !data.status.include?("Active")}.select{|data| data.id != myID}
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

                search.update(doctor:params[:doctor],specialty:params[:specialty],crm:params[:crm],date:params[:date],hour:params[:timeSchedule],patient_Name:params[:patient_Name],patient_Email:params[:patient_Email])

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

            search = Schedule.find_by(id:params[:id])

            

         end

end
