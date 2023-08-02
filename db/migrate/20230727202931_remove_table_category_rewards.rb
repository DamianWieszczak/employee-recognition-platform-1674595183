class RemoveTableCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    drop_table :category_rewards
  end
end
