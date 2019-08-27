module FacetedSearch
  class Facets::PrimitiveList < Facets::DefaultList

    def source
      @options[:source]
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
      unless @values
        @values = source
        @values.reverse! unless order == :asc
      end
      @values
    end
  end
end
