class AddCompletedToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :completed, :integer
  end
end
