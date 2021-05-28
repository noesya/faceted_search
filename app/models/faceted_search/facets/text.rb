module FacetedSearch
  class Facets::Text < Facets::Default
    include ActiveRecord::Sanitization

    def placeholder
      @options[:placeholder]
    end

    def add_scope(scope)
      return scope if params.blank?
      scope.where("#{facets.model_table_name}.#{name} ILIKE ?", "%#{self.class.sanitize_sql_like(params)}%")
    end
  end
end