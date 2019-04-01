module FacetedSearch
  class Facets::List < Facets::DefaultList

    # Adds a scope corresponding to this facet
    # to the scope sent as an argument
    # and return the modified scope
    def add_scope(scope)
      return scope if params_array.blank?

      habtm?  ? scope.joins(name).where(name => { find_by => params_array })
              : scope.where(name => params_array)
    end

    def path_for(value)
      value = value.to_s
      custom_params = params_array.dup
      value_selected?(value)  ? custom_params.delete(value)
                              : custom_params.push(value)
      path(custom_params.join(','))
    end
  end
end