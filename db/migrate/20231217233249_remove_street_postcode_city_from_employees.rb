class RemoveStreetPostcodeCityFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_columns :employees, :street, :postcode, :city
  end
end
