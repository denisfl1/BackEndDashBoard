class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :doctor
      t.string :specialty
      t.string :crm
      t.date :date
      t.string :hour
      t.string :patient_Name 
      t.string :patient_Email
      t.timestamps

    end
  end
end
