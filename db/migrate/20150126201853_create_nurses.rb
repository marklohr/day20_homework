class CreateNurses < ActiveRecord::Migration
  def change
    create_table :nurses do |t|
      t.string :name
      t.string :gender
      t.integer :nursable_id
      t.string :doctorable_type
      t.timestamps null: false
    end
  end
end
