class Item::Facets < FacetedSearch::Facets
  def define
    set_model Item.all
    search :title
    filter :products, find_by: :title
    filter :kinds
    filter :categories
  end
end