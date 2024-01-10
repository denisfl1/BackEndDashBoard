class EditCollumn < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :contactNumber, :string
  end
end
