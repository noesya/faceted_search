module FacetedSearch
  class Facets::Tree < Facets::DefaultList

    def children_scope
      @options[:children_scope] ||= Proc.new { |children| children }
    end

    def selected_objects
      source.where(find_by => params_array)
    end

    def selected_object
      source.find_by(find_by => params_array.last)
    end

    # All values, not filtered
    # Otherwise, we would need to search all the children to do a good filtering
    def values
      root? ? values_root
            : values_children
    end

    protected

    def values_root
      source.root
    end

    def values_children
      children_scope.call selected_object.children
    end

    def root?
      params_array.empty?
    end
  end
end