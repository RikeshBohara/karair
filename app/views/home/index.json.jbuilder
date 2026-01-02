json.user do
  if user_signed_in?
    json.id current_user.id
    json.email current_user.email
    json.role current_user.role
    json.profile_completed current_user.profile_completed
  else
    json.nil!
  end
end

if user_signed_in?
  if current_user.applicant?
    json.applied_jobs @applied_jobs do |job|
      json.extract! job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
      json.user_email job.user.email
      if job.image.attached?
        json.image_url url_for(job.image)
      end
      json.application_count job.job_applications.count
    end
  elsif current_user.recruiter?
    json.active_jobs @active_jobs do |job|
      json.extract! job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
      json.user_email job.user.email
      if job.image.attached?
        json.image_url url_for(job.image)
      end
      json.application_count job.job_applications.count
    end
    
    json.expired_jobs @expired_jobs do |job|
      json.extract! job, :id, :title, :description, :location, :job_type, :end_date, :created_at, :updated_at
      json.user_email job.user.email
      if job.image.attached?
        json.image_url url_for(job.image)
      end
      json.application_count job.job_applications.count
    end
  end
end

