class AddAvailableToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :available, :integer, optional: :true
  end
end
