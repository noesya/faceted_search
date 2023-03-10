class AddStyleToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :style, foreign_key: true
  end
end
