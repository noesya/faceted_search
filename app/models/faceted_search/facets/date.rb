module FacetedSearch
  class Facets::Date < Facets::DefaultList

    def source
      @source ||= begin
        if @options[:source].present?
          @options[:source]
        else
          results = params_array.blank? ? facets.results : facets.results_except(@name)
          results.send(:all).pluck(name).compact.map(&:year).uniq.sort
        end
      end
    end

    def order
      @options[:order]&.to_sym || :asc
    end

    def add_scope(scope)
      return scope if params_array.blank?

      scope.where(
        "EXTRACT(YEAR from #{facets.model_table_name}.#{name}) IN (?)",
        params_array.map(&:to_i)
      )
    end

    def values
      @values ||= order == :asc ? source : source.reverse
    end
  end
end