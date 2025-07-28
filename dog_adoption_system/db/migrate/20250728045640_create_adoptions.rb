class CreateAdoptions < ActiveRecord::Migration[8.0]
  def change
    create_table :adoptions do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: true
      t.date :adoption_date
      t.decimal :adoption_fee
      t.text :notes

      t.timestamps
    end
  end
end
