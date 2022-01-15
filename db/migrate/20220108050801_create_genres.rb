class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.references :user, foreign_key: true
      t.references :cooking, foreign_key: true
      t.string :genre_name, null: false
      t.timestamps
    end
  end
end
