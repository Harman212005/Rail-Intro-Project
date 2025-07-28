class CreateDogs < ActiveRecord::Migration[8.0]
  def change
    create_table :dogs do |t|
      t.string :breed
      t.string :name
      t.integer :age
      t.string :image_url
      t.text :description
      t.boolean :available_for_adoption

      t.timestamps
    end
  end
end
