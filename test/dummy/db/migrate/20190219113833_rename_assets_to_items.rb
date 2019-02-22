class RenameAssetsToItems < ActiveRecord::Migration[5.2]
  def change
    rename_table :assets, :items
    rename_table :assets_kinds, :items_kinds
    rename_table :assets_categories, :categories_items
    rename_table :assets_products, :items_products
    rename_column :items_kinds, :asset_id, :item_id
    rename_column :categories_items, :asset_id, :item_id
    rename_column :items_products, :asset_id, :item_id
  end
end
