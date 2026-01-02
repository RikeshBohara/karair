json.array! @notifications do |notification|
  json.extract! notification, :id, :message, :read_at, :created_at, :updated_at
  json.read notification.read_at.present?
  
  json.recipient do
    json.id notification.recipient.id
    json.email notification.recipient.email
  end
  
  json.actor do
    json.id notification.actor.id
    json.email notification.actor.email
    if notification.actor.profile.present?
      json.profile do
        json.first_name notification.actor.profile.first_name
        json.last_name notification.actor.profile.last_name
        json.headline notification.actor.profile.headline
        json.photo_url notification.actor.profile.photo.attached? ? url_for(notification.actor.profile.photo) : nil
      end
    end
  end
  
  json.notifiable do
    json.type notification.notifiable_type
    json.id notification.notifiable_id
    if notification.notifiable_type == "JobApplication"
      json.job_title notification.notifiable.job.title if notification.notifiable.respond_to?(:job)
    end
  end
end

