json.extract! @job_application, :id, :status, :cover_letter, :created_at, :updated_at
json.job_title @job_application.job.title
json.applicant_email @job_application.user.email
json.job do
  json.extract! @job_application.job, :id, :title, :description, :location, :job_type, :end_date
end
json.applicant do
  json.extract! @job_application.user, :id, :email
  json.profile do
    json.extract! @job_application.user.profile, :first_name, :last_name, :company_name, :headline
  end
end
