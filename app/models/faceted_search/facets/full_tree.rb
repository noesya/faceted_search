module FacetedSearch
  class Facets::FullTree < Facets::DefaultList
    def children_scope
      @options[:children_scope] ||= Proc.new { |children| children }
    end

    def child_values(value)
      children_scope.call value.children
    end

    def values
      source.root
    end
  end
end