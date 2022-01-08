class CreateCookings < ActiveRecord::Migration[5.2]
  def change
    create_table :cookings do |t|
      t.references :meal, foreign_key: true
      t.string :cooking_name, null: false
      t.string :url
      t.timestamps
    end
  end
end
