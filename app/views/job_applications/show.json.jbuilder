json.extract! @job_application, :id, :status, :cover_letter, :created_at, :updated_at

json.job do
  json.extract! @job_application.job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
  json.active @job_application.job.end_date >= Date.today
  json.user_email @job_application.job.user.email
  if @job_application.job.image.attached?
    json.image_url url_for(@job_application.job.image)
  else
    json.image_url nil
  end
  json.user do
    json.id @job_application.job.user.id
    json.email @job_application.job.user.email
    json.role @job_application.job.user.role
    if @job_application.job.user.profile.present?
      json.profile do
        json.company_name @job_application.job.user.profile.company_name
        json.headline @job_application.job.user.profile.headline
        json.location @job_application.job.user.profile.location
        json.contact @job_application.job.user.profile.contact
      end
    end
  end
end

json.applicant do
  json.id @job_application.user.id
  json.email @job_application.user.email
  json.role @job_application.user.role
  json.profile_completed @job_application.user.profile_completed
  if @job_application.user.profile.present?
    json.profile do
      json.extract! @job_application.user.profile, :first_name, :last_name, :headline, :location, :contact
      json.company_name @job_application.user.profile.company_name if @job_application.user.recruiter?
      json.photo_url @job_application.user.profile.photo.attached? ? url_for(@job_application.user.profile.photo) : nil
      json.resume_url (@job_application.user.applicant? && @job_application.user.profile.resume.attached?) ? url_for(@job_application.user.profile.resume) : nil
    end
  end
end
