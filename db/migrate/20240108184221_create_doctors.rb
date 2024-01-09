class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string  :name
      t.string  :specialty
      t.string  :crm
      t.string  :email
      t.string  :number
      t.timestamps
    end
  end
end
