module FacetedSearch
  class Facets
    attr_reader :list, :params, :model

    def initialize(params)
      if params.is_a? ActionController::Parameters
        @params = params.to_unsafe_hash
      elsif params.is_a? Hash
        @params = params
      else
        @params = {}
      end
      @params = @params.symbolize_keys
      @list = []
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

    def search(value, placeholder: nil, title: nil)
      add(Search.new( name: value,
                      params: params_for(value),
                      placeholder: placeholder,
                      facets: self,
                      title: title))
    end

    def filter(value, find_by: :id, source: nil, habtm: nil, title: nil, display_method: Proc.new { |object| object.to_s })
      add(Filter.new( name: value,
                      params: params_for(value),
                      facets: self,
                      find_by: find_by,
                      source: source,
                      habtm: habtm,
                      title: title,
                      display_method: display_method))
    end

    def params_for(value)
      @params[value] if @params.has_key? value
    end

    def add(facet)
      @list << facet
    end
  end
end