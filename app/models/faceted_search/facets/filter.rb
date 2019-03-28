module FacetedSearch
  class Facets::Filter < Facets::Default

    def tree?
      @options[:tree]
    end

    def display_method
      @options[:display_method] ||= Proc.new { |object| object.to_s }
    end

    # Adds a scope corresponding to this facet
    # to the scope sent as an argument
    # and return the modified scope
    def add_scope(scope)
      return scope if params_array.blank?

      identifiers = params_array.dup
      identifiers << selected_objects.first.descendents if tree?
      identifiers.flatten!

      habtm?  ? scope.joins(name).where(name => { find_by => identifiers })
              : scope.where(name => identifiers)
    end

    def find_by
      @options[:find_by] || :id
    end

    def selected_objects
      values.where(find_by => params_array)
    end

    # Show all values that have corresponding results.
    # This is a regular SQL inner join.
    def values
      @values ||= get_values
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

    def value_selected?(value)
      value.to_s.in? params_array
    end

    def path_for(value)
      value = value.to_s
      return path_for_tree(value) if tree?

      custom_params = params_array.dup
      value_selected?(value)  ? custom_params.delete(value)
                              : custom_params.push(value)
      path(custom_params.join(','))
    end

    def source
      @options[:source] || name.to_s.singularize.titleize.constantize.send(:all)
    end

    def has_params?
      params_array.any?
    end

    protected

    def get_values
      joined_table = facets.model_table_name.to_sym
      source.all.joins(joined_table).where(joined_table => { id: facets.model }).distinct
    end

    def path_for_tree(value)
      value_selected?(value) ? path('')
      : path(value)
    end

    def params_array
      @params_array ||= @params.to_s.split(',')
    end

    def habtm?
      @options[:habtm]
    end
  end
end