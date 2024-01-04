Rails.application.routes.draw do


  get "api/data" => "api#getData"
  post "/register"  => "user#register"
  post "/login" => "user#login"

end
