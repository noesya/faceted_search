module FacetedSearch
  class Facets::Filter < Facets::Default
    def path_for(value)
      value = value.to_s
      custom_params = params_array.dup
      selected?(value)  ? custom_params.delete(value)
                        : custom_params.push(value)
      path(custom_params.join(','))
    end

    def selected?(value)
      value.to_s.in? params_array
    end

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    # Adds a scope corresponding to this facet
    # to the scope sent as an argument
    # and return the modified scope 
    def add_scope(scope)
      return scope if params_array.blank?
      @habtm  ? scope.joins(name).where(name => { find_by => params_array })
              : scope.where(name => params_array)
    end

    # Show all values that have corresponding results.
    # FIXME This should be a SQL inner join.
    def values
      join_table = @facets.model_table_name.to_sym
      source.all.joins(join_table).where(join_table => { id: @facets.results }).distinct
    end

    protected

    def source
      @source ||= @name.to_s.singularize.titleize.constantize
    end
  end
end