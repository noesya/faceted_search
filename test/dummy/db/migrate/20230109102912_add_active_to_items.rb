class AddActiveToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :active, :boolean
  end
end
