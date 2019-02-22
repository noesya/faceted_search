class CreateJoinTableAssetsProducts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :assets, :products do |t|
      # t.index [:asset_id, :product_id]
      # t.index [:product_id, :asset_id]
    end
  end
end
