json.array! @jobs do |job|
  json.extract! job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
  json.active job.end_date >= Date.today
  
  json.user do
    json.id job.user.id
    json.email job.user.email
    json.role job.user.role
    if job.user.profile.present?
      json.profile do
        json.company_name job.user.profile.company_name
        json.headline job.user.profile.headline
      end
    end
  end
  
  if job.image.attached?
    json.image_url url_for(job.image)
  else
    json.image_url nil
  end
  
  json.application_count job.job_applications.count
end
