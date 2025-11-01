class AddHeadlineToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :headline, :string
  end
end
