json.user do
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.email @user.email
end
