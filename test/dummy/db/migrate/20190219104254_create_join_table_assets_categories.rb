class CreateJoinTableAssetsCategories < ActiveRecord::Migration[5.2]
  def change
    create_join_table :assets, :categories do |t|
      # t.index [:asset_id, :category_id]
      # t.index [:category_id, :asset_id]
    end
  end
end
