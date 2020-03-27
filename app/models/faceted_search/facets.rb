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
      list.each do |current_facet|
        p += current_facet == facet ? current_facet.path_for(value)
                                    : current_facet.path
      end
      p
    end

    def results
      unless @results
        scope = @model
        list.each do |facet|
          scope = facet.add_scope(scope)
        end
        @results = scope.distinct
      end
      @results
    end

    def model_table_name
      @model.table_name
    end

    def has_params?
      params.values.select(&:present?).any?
    end

    protected

    def filter_with_text(value, options = {})
      add_facet Text, value, options
    end

    def filter_with_date(value, options = {})
      add_facet FacetedSearch::Facets::Date, value, options
    end

    def filter_with_list(value, options = {})
      add_facet List, value, options
    end

    def filter_with_primitive_list(value, options = {})
      add_facet PrimitiveList, value, options
    end

    def filter_with_checkboxes(value, options = {})
      add_facet Checkboxes, value, options
    end

    def filter_with_tree(value, options = {})
      add_facet Tree, value, options
    end

    def filter_with_full_tree(value, options = {})
      add_facet FullTree, value, options
    end

    def params_for(value)
      @params[value] if @params.has_key? value
    end

    def add_facet(kind, value, options)
      @list << kind.new(value, params_for(value), self, options)
    end
  end
end
