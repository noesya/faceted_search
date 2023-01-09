module FacetedSearch
  class Facets::Boolean < Facets::Default

    def selected?
      params == "true"
    end

    def add_scope(scope)
      selected? ? scope.where(name => true)
                : scope
    end

  end
end