class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :number
      t.text :name
      t.text :email

      t.timestamps null: false
    end
  end
end
