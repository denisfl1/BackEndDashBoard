Rails.application.routes.draw do


  get "api/data" => "api#getData"
  get "/getDoctors" => "doctor#getDoctors"
  post "/register"  => "user#register"
  post "/login" => "user#login"
  post "/newdoctor" => "doctor#createDoctor"

end
