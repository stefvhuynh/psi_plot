Rails.application.routes.draw do
  
  root "application#index"
  
  get "/*path" => redirect("/?goto=%{path}")

end
