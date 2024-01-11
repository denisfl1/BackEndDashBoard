Rails.application.routes.draw do


  get "api/data" => "api#getData"
  get "/getDoctors" => "doctor#getDoctors"
  post "/register"  => "user#register"
  post "/registerAdmin"  => "user#register_admin"
  post "/login" => "user#login"
  post "/newdoctor" => "doctor#createDoctor"
  put "/createPassword" => "user#change_Password"

end
