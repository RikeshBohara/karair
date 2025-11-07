json.user do
  json.id @resource ? @resource.id : resource.id
  json.email @resource ? @resource.email : resource.email
  json.role @resource ? @resource.role : resource.role
  json.profile_completed @resource ? @resource.profile_completed : profile_completed
  json.message "Signed up successfully"
end
