json.extract! @job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
json.user_email @job.user.email
if @job.image.attached?
  json.image_url url_for(@job.image)
end
json.job_applications @job_applications do |application|
  json.extract! application, :id, :created_at
  json.applicant_email application.user.email
end

