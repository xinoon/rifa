class AddTelefonoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :telefono, :string
  end
end
