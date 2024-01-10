class AddCollumnPacient < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :zidCode, :string
    add_column :users, :adress, :string
    add_column :users, :neighborhood, :string
    add_column :users, :adressNumber, :string
  end
end
