class Date < ActiveRecord::Migration[7.1]
  def change
    change_column :schedules, :date, :string
  end
end
