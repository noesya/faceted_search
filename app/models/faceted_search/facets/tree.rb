module FacetedSearch
  class Facets::Tree < Facets::DefaultList

    # Adds a scope corresponding to this facet
    # to the scope sent as an argument
    # and return the modified scope
    def add_scope(scope)
      return scope if params_array.blank?

      identifiers = params_array.dup
      identifiers << selected_objects.first.descendents
      identifiers.flatten!

      habtm?  ? scope.joins(name).where(name => { find_by => identifiers })
              : scope.where(name => identifiers)
    end

    def selected_objects
      values.where(find_by => params_array)
    end

    def tree_values
      return values.select { |obj| obj.root? } if params_array.empty?

      selected_object = selected_objects.first
      return [] if selected_object.nil?

      array = []
      array << values.find   { |obj| obj.id == selected_object.parent_id } if selected_object.has_parent?   # parent
      array << values.select { |obj| obj.parent_id == selected_object.parent_id }                           # selected & siblings
      array << values.select { |obj| obj.parent_id == selected_object.id } if selected_object.has_children? # selected object's children
      array.flatten.compact
    end

    def path_for(value)
      value = value.to_s
      value_selected?(value)  ? path('')
                              : path(value)
    end

    def has_params?
      params_array.any?
    end
  end
end