class CreateAddCompanyToProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :add_company_to_profiles do |t|
      t.string :company_name

      t.timestamps
    end
  end
end
