class AddEndDateToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :end_date, :date
  end
end
