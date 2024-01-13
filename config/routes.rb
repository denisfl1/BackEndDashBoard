Rails.application.routes.draw do


  get "api/data" => "api#getData"
  get "/getDoctors" => "doctor#get_Doctors"
  get "/getUsers" => "user#get_Users"
  post "/register"  => "user#register"
  post "/registerAdmin"  => "user#register_admin"
  post "/login" => "user#login"
  post "/newdoctor" => "doctor#createDoctor"
  put "/createPassword" => "user#change_Password"
  delete "/deletedoctor/:id" => "doctor#delete_Doctor"

end
