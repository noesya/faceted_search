module FacetedSearch
  class Facets::Date < Facets::DefaultList

    def source
      @options[:source] || @facets.model.send(:all).pluck(name).compact.map(&:year).uniq.sort
    end

    def add_scope(scope)
      return scope if params_array.blank?

      scope.where(
        "EXTRACT(YEAR from #{facets.model_table_name}.#{name}) IN (?)",
        params_array.map(&:to_i)
      )
    end

    def values
      @values ||= source
    end
  end
end