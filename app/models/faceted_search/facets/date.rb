module FacetedSearch
  class Facets::Date < Facets::DefaultList

    def source
      @source ||= begin
        if @options[:source].present?
          @options[:source]
        else
          results = params_array.blank? ? facets.results : facets.results_except(param_name)
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
      @values ||= begin
        values = (source | params_array.map(&:to_i)).sort
        order == :asc ? values : values.reverse
      end
    end
  end
end