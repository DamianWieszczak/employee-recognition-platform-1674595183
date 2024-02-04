class CreateOnlineCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :online_codes do |t|
      t.string :code
      t.boolean :used, default: false
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
