class Item::Facets < FacetedSearch::Facets
  def initialize(params)
    super
    @model = Item.all
    filter_with_text :title
    filter_with_boolean :active
    filter_with_full_tree :categories, {
      habtm: true
    }
    filter_with_list :products, {
      find_by: :title,
      habtm: true
    }
    filter_with_checkboxes :kinds, {
      habtm: true
    }
    filter_with_list :style, {
      find_by: :title,
      habtm: false
    }
  end
end
