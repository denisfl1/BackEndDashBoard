class ChangeColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :admin, :boolean, default:false

  end
end
