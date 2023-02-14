class CreateKudos < ActiveRecord::Migration[6.1]
  def change
    create_table :kudos do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :receiver, foreign_key: { to_table: :employees }, null: false
      t.references :giver, foreign_key: { to_table: :employees }, null: false

      t.timestamps
    end
  end
end
