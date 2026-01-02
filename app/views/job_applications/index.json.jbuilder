json.array! @job_applications do |job_application|
  json.extract! job_application, :id, :status, :cover_letter, :created_at, :updated_at
  
  json.job do
    json.extract! job_application.job, :id, :title, :description, :location, :job_type, :end_date
    json.user_email job_application.job.user.email
    if job_application.job.image.attached?
      json.image_url url_for(job_application.job.image)
    end
  end
  
  json.applicant do
    json.id job_application.user.id
    json.email job_application.user.email
    if job_application.user.profile.present?
      json.profile do
        json.first_name job_application.user.profile.first_name
        json.last_name job_application.user.profile.last_name
        json.headline job_application.user.profile.headline
        json.location job_application.user.profile.location
        json.photo_url job_application.user.profile.photo.attached? ? url_for(job_application.user.profile.photo) : nil
        json.resume_url (job_application.user.applicant? && job_application.user.profile.resume.attached?) ? url_for(job_application.user.profile.resume) : nil
      end
    end
  end
end
