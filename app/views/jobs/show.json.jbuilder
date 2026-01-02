json.extract! @job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
json.active @job.end_date >= Date.today

json.user do
  json.id @job.user.id
  json.email @job.user.email
  json.role @job.user.role
  if @job.user.profile.present?
    json.profile do
      json.company_name @job.user.profile.company_name
      json.headline @job.user.profile.headline
      json.location @job.user.profile.location
      json.contact @job.user.profile.contact
      json.photo_url @job.user.profile.photo.attached? ? url_for(@job.user.profile.photo) : nil
    end
  end
end

if @job.image.attached?
  json.image_url url_for(@job.image)
else
  json.image_url nil
end

json.job_applications @job_applications do |application|
  json.extract! application, :id, :status, :cover_letter, :created_at, :updated_at
  json.applicant do
    json.id application.user.id
    json.email application.user.email
    if application.user.profile.present?
      json.profile do
        json.first_name application.user.profile.first_name
        json.last_name application.user.profile.last_name
        json.headline application.user.profile.headline
        json.location application.user.profile.location
        json.photo_url application.user.profile.photo.attached? ? url_for(application.user.profile.photo) : nil
        json.resume_url (application.user.applicant? && application.user.profile.resume.attached?) ? url_for(application.user.profile.resume) : nil
      end
    end
  end
end

json.application_count @job_applications.count
