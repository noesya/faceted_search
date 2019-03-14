module FacetedSearch
  class Facets::Search < Facets::Default
    attr_reader :placeholder

    def initialize( name:,
                    params:,
                    facets:,
                    placeholder: nil,
                    find_by: nil,
                    source: nil,
                    habtm: false,
                    title: nil)
      super(name: name,
            title: title,
            facets: facets,
            params: params,
            find_by: find_by,
            source: source,
            habtm: habtm,
            title: title)
      @placeholder = placeholder
    end

    def add_scope(scope)
      return scope if @params.blank?
      scope.where("#{@facets.model_table_name}.#{name} ILIKE ?", "%#{@params}%")
    end
  end
end