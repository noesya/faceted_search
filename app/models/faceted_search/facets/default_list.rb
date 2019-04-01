module FacetedSearch
  class Facets::DefaultList < Facets::Default

    def display_method
      @options[:display_method] ||= Proc.new { |object| object.to_s }
    end

    def find_by
      @options[:find_by] || :id
    end

    def source
      @options[:source] || name.to_s.singularize.titleize.constantize.send(:all)
    end

    def value_selected?(value)
      value.to_s.in? params_array
    end

    def values
      @values ||= get_values
    end

    protected

    # Show all values that have corresponding results.
    # This is a regular SQL inner join.
    def get_values
      joined_table = facets.model_table_name.to_sym
      source.all.joins(joined_table).where(joined_table => { id: facets.model }).distinct
    end

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    def habtm?
      @options[:habtm]
    end

  end
end
