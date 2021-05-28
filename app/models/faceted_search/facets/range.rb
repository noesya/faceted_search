module FacetedSearch
  class Facets::Range < Facets::Default
    def min
      @options[:min] || 0
    end

    def max
      @options[:max] || 100
    end

    def step
      @options[:step] || 1
    end

    def default_value
      @options[:default_value] || min
    end

    def add_scope(scope)
      return scope if params.blank?
      scope.where("#{facets.model_table_name}.#{name}" => params)
    end
  end
end