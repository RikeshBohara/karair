class DropAddCompanyToProfilesTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :add_company_to_profiles
  end
end
