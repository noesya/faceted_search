module FacetedSearch
  class Facets::Filter < Facets::Default
    def path_for(value)
      value = value.to_s
      custom_params = params_array.dup
      selected?(value) ? custom_params.delete(value)
                    : custom_params.push(value)
      path(custom_params.join(','))
    end

    def selected?(value)
      value.to_s.in? params_array
    end

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    def add_scope(scope)
      return scope if params_array.blank?
      scope.joins(name).where(name => { find_by => params_array })
    end

    def values
      source.all
    end

    def source
      @name.to_s.singularize.titleize.constantize
    end
  end
end