module FacetedSearch
  class Facets::Search < Facets::Default

    def placeholder
      @options[:placeholder]
    end

    def add_scope(scope)
      return scope if params.blank?
      scope.where("#{facets.model_table_name}.#{name} ILIKE ?", "%#{params}%")
    end
  end
end