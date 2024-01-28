class StatusColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :status, :string, default:"Active"
  end
end
