class AddEntriesCountToHars < ActiveRecord::Migration[5.1]
  def change
    add_column :hars, :entries_count, :integer
    add_index :hars, :entries_count
  end
end
