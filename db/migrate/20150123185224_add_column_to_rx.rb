class AddColumnToRx < ActiveRecord::Migration
  def change
    
      add_column :doctors, :first_name, :string
      add_column :doctors, :last_name, :string
      add_column :doctors, :gender_name, :string
      add_column :doctors, :specialty, :string
      add_column :doctors, :biography, :text

      add_column :medications, :name, :string
      add_column :medications, :side_effects, :string
      
        
  end
end
