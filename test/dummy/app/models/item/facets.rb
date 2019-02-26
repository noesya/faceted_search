class Item::Facets < FacetedSearch::Facets
  def define
    set_model Item.all
    search :title
    filter :products, find_by: :title, habtm: true
    filter :kinds, habtm: true
    filter :categories, habtm: true
  end
end