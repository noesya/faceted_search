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
      habtm?  ? add_scope_with_habtm_true(scope)
              : add_scope_with_habtm_false(scope)
    end

    # Show all values that have corresponding results with the current params.
    # This is a regular SQL inner join.
    def values
      @values ||= habtm?  ? values_with_habtm_true
                          : values_with_habtm_false
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

    def add_scope_with_habtm_true(scope)
      scope.joins(name).where(name => { find_by => params_array })
    end

    def add_scope_with_habtm_false(scope)
      scope.where(name => params_array)
    end

    def results
      params_array.blank? ? facets.results : facets.results_except(param_name)
    end

    def values_with_habtm_true
      joined_table = facets.model_table_name.to_sym
      values = source.all.joins(joined_table)
      values.where(joined_table => { id: results }).or(values.where(id: params_array)).distinct
    rescue
    end

    def values_with_habtm_false
      property = "#{name}_id"
      ids = results.pluck property
      source.where(id: ids)
    end

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    def habtm?
      @options[:habtm]
    end
  end
end
