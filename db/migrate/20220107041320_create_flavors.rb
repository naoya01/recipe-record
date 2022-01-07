class CreateFlavors < ActiveRecord::Migration[5.2]
  def change
    create_table :flavors do |t|
      t.references :post, foreign_key: true
      t.string :flavor_name, null: false
      t.string :flavor_quantity, null: false
      t.timestamps
    end
  end
end
