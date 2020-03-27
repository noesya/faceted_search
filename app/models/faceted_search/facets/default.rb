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
      "&facets[#{name}]=#{custom_params}"
    end

    def to_s
      "#{title}"
    end
  end
end
