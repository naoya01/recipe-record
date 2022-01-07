class CreateFoodstuffs < ActiveRecord::Migration[5.2]
  def change
    create_table :foodstuffs do |t|
      t.references :post, foreign_key: true
      t.string :foodstuff_name, null: false
      t.string :foodstuff_quantity, null: false
      t.timestamps
    end
  end
end
