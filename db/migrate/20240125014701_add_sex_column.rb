class AddSexColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors,:sex,:string
  end
end
