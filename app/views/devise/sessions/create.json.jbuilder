json.user do
  json.id @resource.id
  json.email @resource.email
  json.message "Signed in successfully"
end
