class AddColumnStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :string, default: "vacio"
  end
end
