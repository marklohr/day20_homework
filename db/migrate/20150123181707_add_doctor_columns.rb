class AddDoctorColumns < ActiveRecord::Migration
  def change
      add_column :doctors, :name, :string
      add_column :medications, :name, :string
  end
end
