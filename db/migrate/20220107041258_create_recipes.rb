class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :post, foreign_key: true
      t.text :recipe_description, null: false
      t.string  :recipe_image_id
      t.timestamps
    end
  end
end
