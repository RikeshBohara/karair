class NotificationsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!

  def index
    if params[:status] == "all"
      @notifications = current_user.notifications.order(created_at: :desc)
    else
      @notifications = current_user.notifications.unread.order(created_at: :desc)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    if @notification.update(read_at: Time.current)
      respond_to do |format|
        format.html { redirect_to notifications_path, notice: "Notification marked as read." }
        format.json { render :mark_as_read, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to notifications_path, alert: "Failed to mark notification as read." }
        format.json { render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
end
