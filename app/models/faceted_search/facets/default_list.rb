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

    # Adds a scope corresponding to this facet
    # to the scope sent as an argument
    # and return the modified scope
    def add_scope(scope)
      return scope if params_array.blank?

      habtm?  ? scope.joins(name).where(name => { find_by => params_array })
              : scope.where(name => params_array)
    end

    # Show all values that have corresponding results with the current params.
    # This is a regular SQL inner join.
    def values
      unless @values
        joined_table = facets.model_table_name.to_sym
        @values = source.all.joins(joined_table).where(joined_table => { id: facets.results }).distinct
      end
      @values
    end

    def value_selected?(value)
      value.to_s.in? params_array
    end

    def path_for(value)
      value = value.to_s
      custom_params = params_array.dup
      value_selected?(value)  ? custom_params.delete(value)
                              : custom_params.push(value)
      path(custom_params.join(','))
    end

    protected

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    def habtm?
      @options[:habtm]
    end
  end
end
