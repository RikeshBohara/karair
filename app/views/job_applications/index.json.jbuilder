json.array! @job_applications do |job_application|
  json.extract! job_application, :id, :created_at, :updated_at
  json.job_title job_application.job.title
  json.applicant_email job_application.user.email
end
