module FacetedSearch
  class Facets::FullTree < Facets::DefaultList
    def children_scope
      @options[:children_scope] ||= Proc.new { |children| children }
    end

    def child_values(value)
      filtered children_scope.call(value.children)
    end

    def values
      filtered source.root
    end

    protected

    def filtered(list)
      joined_table = facets.model_table_name.to_sym
      list.joins(joined_table).where(joined_table => { id: facets.results }).distinct
    end
  end
end