class ReaddEntriesCountToHars < ActiveRecord::Migration[5.1]
  def change
    add_column :hars, :entries_count, :integer, null: false, default: 0
    add_index :hars, :entries_count
  end
end
