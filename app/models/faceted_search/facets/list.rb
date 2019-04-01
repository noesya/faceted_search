module FacetedSearch
  class Facets::List < Facets::DefaultList

    # Show all values that have corresponding results.
    # This is a regular SQL inner join.
    def values
      unless @values
        joined_table = facets.model_table_name.to_sym
        @values = source.all.joins(joined_table).where(joined_table => { id: facets.model }).distinct
      end
      @values
    end
  end
end