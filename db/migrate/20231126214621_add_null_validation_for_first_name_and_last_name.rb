class AddNullValidationForFirstNameAndLastName < ActiveRecord::Migration[6.1]
  def change
    change_column :employees, :first_name, :string, null: false
    change_column :employees, :last_name, :string, null: false
  end
end
