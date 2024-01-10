class EditCollumn1 < ActiveRecord::Migration[7.1]
  def change
    rename_column :users,:adressNumber,:number_adress
    rename_column :users,:contactNumber,:contact_number
    rename_column :users,:zidCode,:zipCode
  end
end
