module FacetedSearch
  class Facets::Tree < Facets::DefaultList

    def selected_objects
      source.where(find_by => params_array)
    end

    def selected_object
      selected_objects.last
    end

    # All values, not filtered
    # Otherwise, we would need to search all the children to do a good filtering
    def values
      root? ? source.root
            : selected_object.children
    end

    protected

    def root?
      params_array.empty?
    end
  end
end