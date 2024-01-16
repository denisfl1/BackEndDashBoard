Rails.application.routes.draw do


  get "api/data" => "api#getData"
  get "/getDoctors" => "doctor#get_Doctors"
  get "/getUsers" => "user#get_Users"
  get "/getuser/:id" => "user#get_User"
  get "/getdoctor/:id" => "doctor#get_Doctor"
  get "/getschedules" => "schedule#get_schedules"
  post "/register"  => "user#register"
  post "/registerAdmin" => "user#register_admin"
  post "/login" => "user#login"
  post "/newdoctor" => "doctor#createDoctor"
  put "/createPassword" => "user#change_Password"
  put "/edituser" => "user#edit_User"
  delete "/deletedoctor/:id" => "doctor#delete_Doctor"
  delete "/deleteuser/:id" => "user#delete_User"

end
