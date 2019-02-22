module FacetedSearch
  class Facets
    attr_reader :list, :params

    def initialize(params)
      if params.is_a? ActionController::Parameters
        @params = params.to_unsafe_hash
      elsif params.is_a? Hash
        @params = params
      else
        @params = {}
      end
      @params.symbolize_keys!
      @list = []
      define
    end

    def path
      '?facets'
    end

    def path_for(facet, value)
      p = path
      @list.each do |current_facet|
        p += current_facet == facet ? current_facet.path_for(value)
                                    : current_facet.path
      end
      p
    end

    def results
      scope = @model
      list.each do |facet|
        scope = facet.add_scope(scope)
      end
      scope
    end

    def model_table_name
      @model.table_name
    end

    protected

    def define
      # Override
    end

    def set_model(model)
      @model = model
    end

    def search(value)
      add(Search.new( name: value,
                      params: params_for(value),
                      facets: self))
    end

    def filter(value, find_by: :id)
      add(Filter.new( name: value,
                      params: params_for(value),
                      facets: self,
                      find_by: find_by))
    end

    def params_for(value)
      @params[value] if @params.has_key? value
    end

    def add(facet)
      @list << facet
    end
  end
end