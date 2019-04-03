module FacetedSearch
  class Facets::List < Facets::DefaultList

    # Show all values that have corresponding results with the current params.
    # This is a regular SQL inner join.
    def values
      unless @values
        joined_table = facets.model_table_name.to_sym
        @values = source.all.joins(joined_table).where(joined_table => { id: facets.results }).distinct
      end
      @values
    end
  end
end