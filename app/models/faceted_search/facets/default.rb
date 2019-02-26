module FacetedSearch
  class Facets::Default
    attr_reader :name, :params, :facets, :find_by

    def initialize( name:,
                    params:,
                    facets:,
                    find_by: nil,
                    source: nil,
                    habtm: false,
                    title: nil)
      @name = name
      @title = title
      @params = params
      @facets = facets
      @find_by = find_by
      @source = source
      @habtm = habtm
    end

    def title
      @title ||= name.to_s.humanize.titleize
    end

    def kind
      self.class.to_s
    end

    def path_for(value)
      "&facets[#{name}]=#{value}"
    end

    def add_scope(scope)
      # Override
      scope
    end

    def path(custom_params = @params)
      return '' if custom_params.blank?
      "&facets[#{@name}]=#{custom_params}"
    end

    def to_s
      "#{title}"
    end
  end
end
