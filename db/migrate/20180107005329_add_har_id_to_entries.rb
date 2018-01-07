class AddHarIdToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :har_id, :integer, null: false
    add_index :entries, :har_id
  end
end
