class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :post_name, null: false
      t.text :post_description
      t.string :post_image_id
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
