json.user do
  json.id @resource.id
  json.email @resource.email
  json.role @resource.role
  json.message "Signed in successfully"
end
