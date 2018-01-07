class DropEntriesCountFromHars < ActiveRecord::Migration[5.1]
  def change
    remove_column :hars, :entries_count
  end
end
