module FacetedSearch
  class Facets::FullTree < Facets::DefaultList
    def values_with_parent(parent_id)
      values.where(parent_id: parent_id)
    end
  end
end