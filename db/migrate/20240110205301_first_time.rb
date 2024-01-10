class FirstTime < ActiveRecord::Migration[7.1]
  def change
    add_column :users,:firstTime,:boolean,default:false
  end
end
