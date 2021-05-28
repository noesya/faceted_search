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
      if facet.path_pattern?
        p = "#{facet.path_pattern.call(value)}#{path}"
        list.each do |current_facet|
          p += current_facet.path if current_facet != facet
        end
      else
        p = path
        list.each do |current_facet|
          next if current_facet.path_pattern?
          p += current_facet == facet ? current_facet.path_for(value)
                                      : current_facet.path
        end
      end
      p
    end

    def results
      unless @results
        scope = @model
        list.each do |facet|
          scope = facet.add_scope(scope) unless facet.ignore_scope?
        end
        @results = scope.distinct
      end
      @results
    end

    def model_table_name
      @model.table_name
    end

    def has_params?
      any = false
      list.each do |facet|
        next if facet.hide_in_selected?
        any = true if facet.params.present?
      end
      any
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

    def filter_with_range(value, options = {})
      add_facet Range, value, options
    end

    def params_for(value)
      @params[value] if @params.has_key? value
    end

    def add_facet(kind, value, options)
      @list << kind.new(value, params_for(value), self, options)
    end
  end
end
