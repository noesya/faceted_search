module FacetedSearch
  class Facets::Text < Facets::Default
    include ActiveRecord::Sanitization

    def placeholder
      @options[:placeholder]
    end

    def add_scope(scope)
      return scope if params.blank?
      scope.where(where_condition, search_term: "%#{self.class.sanitize_sql_like(params)}%")
    end

    protected

    def where_condition
      # PostgreSQL handles removing accents if `unaccent` extension is enabled
      if ActiveRecord::Base.connection.adapter_name == "PostgreSQL" && ActiveRecord::Base.connection.extensions.include?('unaccent')
        "unaccent(#{facets.model_table_name}.#{name}) ILIKE unaccent(:search_term)"
      else
        "#{facets.model_table_name}.#{name} ILIKE :search_term"
      end
    end
  end
end