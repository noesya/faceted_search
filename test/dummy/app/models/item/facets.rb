class Item::Facets < FacetedSearch::Facets
  def initialize(params)
    super
    @model = Item.all
    search :title
    filter :products, {
      find_by: :title,
      habtm: true
    }
    filter :kinds, {
      habtm: true
    }
    filter :categories, {
      habtm: true,
      tree: true
    }
  end
end