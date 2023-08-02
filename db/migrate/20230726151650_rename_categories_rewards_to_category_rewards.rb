class RenameCategoriesRewardsToCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    rename_table :categories_rewards, :category_rewards
  end
end
