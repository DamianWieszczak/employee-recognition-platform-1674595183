class CreateCategoriesRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_rewards do |t|
      t.integer :category_id
      t.integer :reward_id
      t.timestamps
    end
  end
end
