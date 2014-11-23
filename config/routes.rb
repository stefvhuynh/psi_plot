Rails.application.routes.draw do
  root to: 'pages#main'
  get '/*path' => redirect('/?goto=%{path}')
end
