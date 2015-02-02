class FixColumnNamesForNurse < ActiveRecord::Migration
  def change
    change_table :nurses do |t|
    t.rename :nursable_id, :nurseable_id
    t.rename :doctorable_type, :nurseable_type
    end
  end
end
