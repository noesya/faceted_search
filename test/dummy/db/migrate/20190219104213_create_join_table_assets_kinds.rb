class CreateJoinTableAssetsKinds < ActiveRecord::Migration[5.2]
  def change
    create_join_table :assets, :kinds do |t|
      # t.index [:asset_id, :kind_id]
      # t.index [:kind_id, :asset_id]
    end
  end
end
