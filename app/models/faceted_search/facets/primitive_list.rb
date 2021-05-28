module FacetedSearch
  class Facets::PrimitiveList < Facets::DefaultList

    def source
      @source ||= begin
        if @options[:source].present?
          @options[:source]
        else
          results = params_array.compact.blank? ? facets.results : facets.results_except(@name)
          results.send(:all).where("#{field} IS NOT NULL")
        end
      end
      @options[:source].where("#{field} IS NOT NULL")
    end

    def order
      @options[:order]&.to_sym || :asc
    end

    def field
      @options[:field]
    end

    def add_scope(scope)
      return scope if params_array.compact.blank?
      scope.where(
        "#{field} IN (?)",
        params_array.compact
      )
    end

    def values
      @values ||= begin
        values = (source.pluck(field).uniq.reject(&:blank?) | params_array.compact).sort
        order == :asc ? values : values.reverse
      end
    end
  end
end
