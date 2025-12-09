json.array! @jobs do |job|
  json.extract! job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
  json.user_email job.user.email
  if job.image.attached?
    json.image_url url_for(job.image)
  end
end
