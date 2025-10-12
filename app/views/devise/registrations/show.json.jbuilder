json.user do
  json.id @user ? @user.id : resource.id
  json.email @user ? @user.email : resource.email
  json.message "Signed up successfully"
end
