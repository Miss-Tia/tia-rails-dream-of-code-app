class RemoveCurrentFromTrimesters < ActiveRecord::Migration[8.0]
  def change
    remove_column :trimesters, :current, :boolean
  end
end
