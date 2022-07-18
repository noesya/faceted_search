module FacetedSearch
  class Facets::Default
    attr_reader :name, :params, :facets

    def initialize(name, params, facets, options)
      @name = name
      @params = params
      @facets = facets
      @options = options
    end

    def title
      @options[:title] || name.to_s.humanize.titleize
    end

    def searchable
      @options[:searchable] || false
    end

    def path_pattern
      @options[:path_pattern] || false
    end

    def path_pattern?
      @options.has_key? :path_pattern
    end

    def ignore_scope?
      @options[:ignore_scope] || false
    end

    def hide_in_selected?
      @options[:hide_in_selected] || path_pattern?
    end

    def param_name
      @options[:param_name] || name
    end

    def kind
      self.class.to_s
    end

    def path_for(value)
      path(value)
    end

    def add_scope(scope)
      # Override
      scope
    end

    def path(custom_params = @params)
      return '' if custom_params.blank?
      "&facets[#{param_name}]=#{custom_params}"
    end

    def to_s
      "#{title}"
    end
  end
end
