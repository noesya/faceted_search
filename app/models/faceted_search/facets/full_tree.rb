module FacetedSearch
  class Facets::FullTree < Facets::DefaultList
    def values_with_parent(parent_id)
      values.select { |v| v.parent_id ==  parent_id }
    end
  end
end