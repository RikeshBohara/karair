json.profile do
  json.id @profile.id
  json.first_name @profile.first_name
  json.last_name @profile.last_name
  json.company_name @profile.company_name
  json.headline @profile.headline
  json.location @profile.location
  json.contact @profile.contact
  json.created_at @profile.created_at
  json.updated_at @profile.updated_at

  json.photo_url @profile.photo.attached? ? url_for(@profile.photo) : nil

  json.resume_url (@profile.user.applicant? && @profile.resume.attached?) ? url_for(@profile.resume) : nil

  json.user do
    json.id @profile.user.id
    json.email @profile.user.email
    json.role @profile.user.role
    json.profile_completed @profile.user.profile_completed
  end
end
