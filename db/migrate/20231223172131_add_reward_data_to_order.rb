class AddRewardDataToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :reward_data, :text
  end
end
