class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.text :meal_description
      t.date :date, null: false
      t.string :mealtime, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
