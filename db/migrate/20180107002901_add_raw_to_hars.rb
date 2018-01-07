class AddRawToHars < ActiveRecord::Migration[5.1]
  def change
    add_column :hars, :raw, :jsonb
  end
end
