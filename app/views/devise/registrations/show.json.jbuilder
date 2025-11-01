json.user do
  json.id @resource ? @resource.id : resource.id
  json.email @resource ? @resource.email : resource.email
  json.role @resource ? @resource.role : resource.role
  json.message "Signed up successfully"
end
