json.user do
  json.id @user ? @user.id : resource.id
  json.email @user ? @user.email : resource.email
  json.role @user ? @user.role : resource.role
  json.message "Signed up successfully"
end
