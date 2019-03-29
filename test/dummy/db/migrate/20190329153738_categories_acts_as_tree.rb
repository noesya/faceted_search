class CategoriesActsAsTree < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :parent, foreign_key: {to_table: :categories}
  end
end
