class AddStatusToJobApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :job_applications, :status, :integer, default: 0
    JobApplication.update_all(status: 0)
  end
end
