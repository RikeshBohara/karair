json.user do
  json.id @resource.id
  json.email @resource.email
  json.role @resource.role
  json.profile_completed @resource.profile_completed
  json.message "Signed in successfully"
end
