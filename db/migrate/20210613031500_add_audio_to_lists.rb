class AddAudioToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :audio, :string
  end
end
