json.extract! @notification, :id, :message, :read_at, :created_at, :updated_at
json.read @notification.read_at.present?

json.recipient do
  json.id @notification.recipient.id
  json.email @notification.recipient.email
end

json.actor do
  json.id @notification.actor.id
  json.email @notification.actor.email
  if @notification.actor.profile.present?
    json.profile do
      json.first_name @notification.actor.profile.first_name
      json.last_name @notification.actor.profile.last_name
      json.headline @notification.actor.profile.headline
    end
  end
end

json.notifiable do
  json.type @notification.notifiable_type
  json.id @notification.notifiable_id
end

json.message "Notification marked as read"

